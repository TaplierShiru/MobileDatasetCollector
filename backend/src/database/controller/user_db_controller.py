import traceback
from typing import List, Dict, Union

from src.database.controller.session_controller import get_session
from src.database.tables import User
from src.database.utils import get_hash, ROLE_ADMIN


class UserDbController:

    @staticmethod
    def get_user(user: User) -> Union[User, None]:
        try:
            with get_session() as session:
                user: User = session.query(User).filter_by(id=user.id).first()
                return user
        except Exception as e:
            print(e)
            traceback.print_exc()

    @staticmethod
    def is_exist(user: User) -> bool:
        try:
            with get_session() as session:
                user: User = session.query(User).filter_by(email=user.email).first()
                if user is None:
                    return False
                return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def add_user(user: User) -> bool:
        try:
            if UserDbController.is_exist(user):
                return False
            # Create salt and hash for password
            salt, hashpass = get_hash(password=user.password)
            user.salt = salt
            user.role = ROLE_ADMIN
            with get_session() as session:
                session.add(user)
                session.commit()
                return True
        except Exception as e:
            print(e)
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
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def login(email: str, password: str) -> Union[User, None]:
        try:
            with get_session() as session:
                user: User = session.query(User).filter_by(email=email).first()
                if not UserDbController.is_exist(user):
                    return
                hashbytes, _ = get_hash(password=password, salt=user.salt)
                if hashbytes == user.password:
                    return user
        except Exception as e:
            print(e)
            traceback.print_exc()

    @staticmethod
    def get_user_role(user: User) -> str:
        try:
            with get_session() as session:
                user: User = session.query(User).filter_by(id=user.id).first()
                if user is None:
                    return
                return user.role
        except Exception as e:
            print(e)
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
            print(e)
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