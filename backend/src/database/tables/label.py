import uuid

from sqlalchemy import Column, String, LargeBinary, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from .base import Base


class Label(Base):
    __tablename__ = 'labels'
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    label_name = Column(String)

    folder_id = Column(String, ForeignKey('folders.id'))
    folder = relationship('Folder')
    folder_elements = relationship('FolderElement')

    def __init__(self, label_name):
        self.label_name = label_name

    def __repr__(self):
        return "<Label('%s')>" % self.label_name
