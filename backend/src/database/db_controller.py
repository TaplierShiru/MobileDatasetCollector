import os
import traceback
from typing import Dict, List

from sqlalchemy.orm import sessionmaker

from .utils import create_engine, get_hash, ROLE_USER, ROLE_ADMIN
from .tables import Base, User


ENGINE = create_engine()
# Create tables
Base.metadata.create_all(ENGINE)

SESSION_MAKER = sessionmaker(bind=ENGINE)
# SESSION = SESSION_MAKER()
SESSION = None


class DataBaseController:

    @staticmethod
    def is_exist(username: str) -> bool:
        # Find user by username aka login
        try:
            user: User = SESSION.query(User).filter_by(login=username).first()
            if user is None:
                return False
            return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def add_user(username: str, password: str, role: str = ROLE_USER) -> bool:
        try:
            # Check exist user ot not with this username
            if DataBaseController.is_exist(username):
                return False
            # Create salt and hash for password
            salt, hashpass = get_hash(password=password)
            user = User(
                login=username, password=hashpass,
                salt=salt, role=role
            )
            SESSION.add(user)
            SESSION.commit()
            return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def remove_user(username: str) -> bool:
        try:
            user: User = SESSION.query(User).filter_by(login=username).first()
            if user is None:
                return False
            SESSION.delete(user)
            SESSION.commit()
            return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def login(username: str, password: str) -> bool:
        try:
            if not DataBaseController.is_exist(username):
                return False
            user: User = SESSION.query(User).filter_by(login=username).first()
            hashbytes = get_hash(password=password, salt=user.salt)
            return hashbytes == user.password
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def get_user_role(username: str) -> str:
        try:
            user: User = SESSION.query(User).filter_by(login=username).first()
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
            user_list: List[User] = SESSION.query(User).all()
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
all_users_list = DataBaseController.get_all_users_data()
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

    DataBaseController.add_user(
        username=admin_username, password=admin_password,
        role=ROLE_ADMIN
    )
"""