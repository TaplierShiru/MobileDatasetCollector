import uuid

from sqlalchemy import Column, String, LargeBinary
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from .base import Base


class Folder(Base):
    __tablename__ = 'folders'
    id = Column(String, primary_key=True, default=uuid.uuid4)
    folder_name = Column(String)

    folder_elements = relationship('FolderElement', cascade='all, delete-orphan', back_populates='folder')
    labels = relationship('Label', cascade='all, delete-orphan', back_populates='folder')

    def __init__(self, folder_name):
        self.folder_name = folder_name

    def __repr__(self):
        return "<Folder('%s')>" % self.folder_name
