from datetime import timedelta
from typing import Union

from fastapi import APIRouter, Depends, HTTPException
from starlette import status

from src.database.controller.user_db_controller import UserDbController
from src.user.dto import UserLoginDto, UserRegisterDto, UserDto, TokenDto
from src.user.utils.auth_bearer import JWTBearer

router = APIRouter(
    prefix='/auth',
    tags=['auth'],
    responses={404: {'description': 'Not found'}},
)


@router.post("/token", response_model=TokenDto, status_code=status.HTTP_200_OK)
async def login(user_login_dto: UserLoginDto):
    user_dto: Union[UserDto, None] = UserDbController.login(user_login_dto.email, user_login_dto.password)
    if user_dto is None:
        # Wrong email/pass
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Incorrect username or password")
    access_token_expires = timedelta(minutes=JWTBearer.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = JWTBearer.create_access_token(
        data={"sub": user_dto.email}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}


@router.post('/register', status_code=status.HTTP_201_CREATED)
async def register(user_register_dto: UserRegisterDto):
    result = UserDbController.add_user(user_register_dto)
    if not result:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Incorrect username or password")


@router.get("/user", response_model=UserDto)
async def get_current_user(current_user: UserDto = Depends(JWTBearer())):
    return current_user
