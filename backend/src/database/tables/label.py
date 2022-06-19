import uuid

from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship

from src.database.tables import Base


class Label(Base):
    __tablename__ = 'labels'
    id = Column(String, primary_key=True, default=lambda: uuid.uuid4().hex)
    label_name = Column(String)

    folder_id = Column(String, ForeignKey('folders.id'), default=lambda: uuid.uuid4().hex)

    folder = relationship('Folder', back_populates='labels')
    folder_element_connection = relationship('FolderElementToLabel', back_populates='label')

    def __init__(self, label_name):
        self.label_name = label_name

    def __repr__(self):
        return "<Label('%s')>" % self.label_name
