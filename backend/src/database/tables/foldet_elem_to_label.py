import uuid

from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship

from src.database.tables import Base


class FolderElementToLabel(Base):
    __tablename__ = 'folder_elements_to_labels'
    id = Column(String, primary_key=True, default=lambda: uuid.uuid4().hex)

    label_id = Column(String, ForeignKey('labels.id'), default=lambda: uuid.uuid4().hex)
    folder_elem_id = Column(String, ForeignKey('folder_elements.id'), default=lambda: uuid.uuid4().hex)

    label = relationship('Label', back_populates='folder_element_connection')
    folder_element = relationship('FolderElement', back_populates='label_connection')

    def __repr__(self):
        return "<FolderElementToLabel('%s')>" % self.id
