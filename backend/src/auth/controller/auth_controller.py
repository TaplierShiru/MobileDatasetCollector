from typing import Union

from fastapi import APIRouter
from starlette import status
from starlette.responses import Response

from src.auth.dto import UserLoginDto, UserRegisterDto
from src.database.controller.user_db_controller import UserDbController
from src.database.tables import User

router = APIRouter(
    prefix='/auth',
    tags=['auth'],
    responses={404: {'description': 'Not found'}},
)


@router.post("/login", response_model=UserLoginDto, status_code=status.HTTP_200_OK)
async def login(user_login_dto: UserLoginDto, response: Response):
    user: Union[User, None] = UserDbController.login(user_login_dto.email, user_login_dto.password)
    if user:
        return user
    # Wrong email/pass
    response.status_code = status.HTTP_401_UNAUTHORIZED


@router.post('/register', response_model=UserRegisterDto, status_code=status.HTTP_200_OK)
async def register(user_register_dto: UserRegisterDto, response: Response):
    user = User(
        user_register_dto.email, user_register_dto.firstName, user_register_dto.lastName,
        user_register_dto.phone, user_register_dto.password, None, None
    )
    result = UserDbController.add_user(user)
    if not result:
        response.status_code = status.HTTP_401_UNAUTHORIZED

