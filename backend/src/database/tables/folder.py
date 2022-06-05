import uuid

from sqlalchemy import Column, String
from sqlalchemy.orm import relationship

from src.database.tables import Base


class Folder(Base):
    __tablename__ = 'folders'
    id = Column(String, primary_key=True, default=lambda: uuid.uuid4().hex)
    folder_name = Column(String)

    folder_elements = relationship('FolderElement', cascade='all, delete-orphan', back_populates='folder')
    labels = relationship('Label', cascade='all, delete-orphan', back_populates='folder')

    def __init__(self, folder_name):
        self.folder_name = folder_name

    def __repr__(self):
        return "<Folder('%s')>" % self.folder_name
