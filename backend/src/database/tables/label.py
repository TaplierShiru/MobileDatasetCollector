import uuid

from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship

from .base import Base


class Label(Base):
    __tablename__ = 'labels'
    id = Column(String, primary_key=True, default=uuid.uuid4)
    label_name = Column(String)

    folder_id = Column(String, ForeignKey('folders.id'), default=uuid.uuid4)

    folder = relationship('Folder', back_populates='labels')
    folder_element_connection = relationship('FolderElement', back_populates='label')

    def __init__(self, label_name):
        self.label_name = label_name

    def __repr__(self):
        return "<Label('%s')>" % self.label_name
