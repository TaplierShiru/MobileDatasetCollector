import traceback
from typing import List, Dict, Union

from sqlalchemy.orm import Session

from src.database.controller.session_controller import get_session
from src.database.tables import User
from src.database.utils import get_hash, ROLE_ADMIN
from src.user.dto import UserRegisterDto
from src.user.dto.user_dto import UserDto
from src.utils import log


class UserDbController:

    @staticmethod
    def get_user(email: str) -> Union[UserDto, None]:
        try:
            with get_session() as session:
                user = UserDbController.get_user_with_session(session, None, email)
                if user is None:
                    return
                return UserDto.from_database(user)
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def get_user_with_session(session: Session, id: Union[str, None], email: Union[str, None] = None) -> Union[User, None]:
        try:
            if id is None and email is None:
                raise Exception('Id or email must be provided to `get_user_with_session` function')
            if email is None:
                user: User = session.query(User).filter_by(id=id).first()
            else:
                user: User = session.query(User).filter_by(email=email).first()
            return user
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def add_user(user_register_dto: UserRegisterDto) -> bool:
        try:
            with get_session() as session:
                found_user = UserDbController.get_user_with_session(session, None, email=user_register_dto.email)
                if found_user is not None:
                    log.debug(f'User already exist, input=[{user_register_dto}], existed user=[{found_user}]')
                    return False
                # Create salt and hash for password
                hashpass, salt = get_hash(password=user_register_dto.password)
                user = User(
                    user_register_dto.email, user_register_dto.firstName, user_register_dto.lastName,
                    user_register_dto.phone, password=hashpass, salt=salt, role=ROLE_ADMIN
                )
                session.add(user)
                session.commit()
                return True
        except Exception as e:
            log.debug(e)
            traceback.print_exc()
        return False

    @staticmethod
    def remove_user(user: User) -> bool:
        try:
            with get_session() as session:
                user: User = session.query(User).filter_by(id=user.id).first()
                if user is None:
                    return False
                session.delete(user)
                session.commit()
                return True
        except Exception as e:
            log.debug(e)
            traceback.print_exc()
        return False

    @staticmethod
    def login(email: str, password: str) -> Union[UserDto, None]:
        try:
            with get_session() as session:
                user: Union[User, None] = UserDbController.get_user_with_session(session, None, email=email)
                if user is None:
                    return
                hashbytes, _ = get_hash(password=password, salt=user.salt)
                if hashbytes != user.password:
                    return
                return UserDto.from_database(user)
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def get_user_with_session_role(user: User) -> Union[str, None]:
        try:
            with get_session() as session:
                user: User = session.query(User).filter_by(id=user.id).first()
                if user is None:
                    return
                return user.role
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def get_all_users_data() -> List[Dict[str, str]]:
        """
        Return dict with data:
            [
                {
                    username: value,
                    role: value,
                    ...
                },
                ...
                {
                    username: value,
                    role: value,
                    ...
                },
            ]

        """
        try:
            with get_session() as session:
                user_list: List[User] = session.query(User).all()
                new_users_list = []
                for user in user_list:
                    new_users_list.append({
                        "username": user.login,
                        "role": user.role,
                    })
                return new_users_list
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

"""
# Check On existing of admin
all_users_list = UserDbController.get_all_users_data()
is_ex = False
for data_dict in all_users_list:
    if data_dict['role'] == ROLE_ADMIN:
        is_ex = True

if not is_ex:
    # Append admin user
    admin_username = 'admin'
    admin_password = 'admin'
    if os.environ.get("ADMIN_USERNAME") is not None:
        admin_username = os.environ.get("ADMIN_USERNAME")

    if os.environ.get("ADMIN_PASSWORD") is not None:
        admin_password = os.environ.get("ADMIN_PASSWORD")

    UserDbController.add_user(
        username=admin_username, password=admin_password,
        role=ROLE_ADMIN
    )
"""