from datetime import timedelta
from typing import Union

from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from jose import jwt, JWTError
from starlette import status

from src.database.controller.user_db_controller import UserDbController
from src.user.dto import UserLoginDto, UserRegisterDto
from src.user.dto.user_dto import UserDto
from src.utils import create_access_token, ACCESS_TOKEN_EXPIRE_MINUTES, SECRET_KEY, ALGORITHM

router = APIRouter(
    prefix='/auth',
    tags=['auth'],
    responses={404: {'description': 'Not found'}},
)

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


@router.post("/token", status_code=status.HTTP_200_OK)
async def login(user_login_dto: UserLoginDto):
    user_dto: Union[UserDto, None] = UserDbController.login(user_login_dto.email, user_login_dto.password)
    if user_dto is None:
        # Wrong email/pass
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user_dto.email}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}


@router.post('/register', status_code=status.HTTP_201_CREATED)
async def register(user_register_dto: UserRegisterDto):
    result = UserDbController.add_user(user_register_dto)
    if not result:
        raise HTTPException(status_code=400, detail="Incorrect username or password")


async def _get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            raise credentials_exception
    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token has been expired",
            headers={"WWW-Authenticate": "Bearer"},
        )
    except JWTError:
        raise credentials_exception
    user: Union[UserDto, None] = UserDbController.get_user(email)
    if user is None:
        raise credentials_exception
    return user


@router.get("/user", response_model=UserDto)
async def get_current_user(current_user: UserDto = Depends(_get_current_user)):
    return current_user
