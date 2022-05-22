from sqlalchemy import Column, String, LargeBinary
from .base import Base
from ..utils.constants import PASSWORD_LEN, SALT_LEN


class User(Base):
    __tablename__ = 'user'
    login = Column(String(12), primary_key=True)
    password = Column(LargeBinary(PASSWORD_LEN))
    salt = Column(LargeBinary(SALT_LEN))
    role = Column(String(20))

    def __init__(self, login, password, salt, role):
        self.login = login
        self.password = password
        self.salt = salt
        self.role = role

    def __repr__(self):
        return "<User('%s', '%s', '%s')>" % (self.fullname, self.password, self.role)
