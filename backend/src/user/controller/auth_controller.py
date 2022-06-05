from typing import Union

from fastapi import APIRouter
from starlette import status
from starlette.responses import Response

from src.user.dto import UserLoginDto, UserRegisterDto
from src.user.dto.user_dto import UserDto
from src.database.controller.user_db_controller import UserDbController
from src.database.tables import User

router = APIRouter(
    prefix='/auth',
    tags=['auth'],
    responses={404: {'description': 'Not found'}},
)


@router.post("/login", response_model=UserDto, status_code=status.HTTP_200_OK)
async def login(user_login_dto: UserLoginDto, response: Response):
    user: Union[User, None] = UserDbController.login(user_login_dto.email, user_login_dto.password)
    if user:
        return UserDto.from_database(user)
    # Wrong email/pass
    response.status_code = status.HTTP_401_UNAUTHORIZED


@router.post('/register', status_code=status.HTTP_201_CREATED)
async def register(user_register_dto: UserRegisterDto, response: Response):
    result = UserDbController.add_user(user_register_dto)
    if not result:
        response.status_code = status.HTTP_401_UNAUTHORIZED

