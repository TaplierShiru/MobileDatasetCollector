import uuid

from sqlalchemy import Column, String, LargeBinary, Date, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from .base import Base


class FolderElementToLabel(Base):
    __tablename__ = 'folder_elements_to_labels'
    id = Column(String, primary_key=True, default=uuid.uuid4)

    label_id = Column(String, ForeignKey('labels.id'), default=uuid.uuid4)
    folder_elem_id = Column(String, ForeignKey('folder_elements.id'), default=uuid.uuid4)

    label = relationship('Label', back_populates='folder_element_connection')
    folder_element = relationship('FolderElement', back_populates='label_connection')

    def __repr__(self):
        return "<FolderElementToLabel('%s')>" % self.id
