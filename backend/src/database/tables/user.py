import uuid

from sqlalchemy import Column, String, LargeBinary
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from .base import Base
from ..utils.constants import PASSWORD_LEN, SALT_LEN


class User(Base):
    __tablename__ = 'users'
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    email = Column(String, unique=True)
    first_name = Column(String)
    last_name = Column(String)
    phone = Column(String)
    role = Column(String)
    password = Column(LargeBinary(PASSWORD_LEN))
    salt = Column(LargeBinary(SALT_LEN))

    folder_elements_changed = relationship('FolderElement', backref='last_user_change', cascade='all, delete')

    def __init__(self, email, first_name, last_name, phone, password, salt, role):
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.phone = phone
        self.password = password
        self.salt = salt
        self.role = role

    def __repr__(self):
        return "<User('%s', '%s', '%s')>" % (self.first_name, self.last_name, self.role)
