import uuid

from sqlalchemy import Column, String, Date, ForeignKey
from sqlalchemy.orm import relationship

from src.database.tables import Base


class FolderElement(Base):
    __tablename__ = 'folder_elements'
    id = Column(String, primary_key=True, default=lambda: uuid.uuid4().hex)
    name = Column(String)
    image_path = Column(String)
    date_uploaded = Column(Date)
    date_changed = Column(Date)

    last_user_change_id = Column(String, ForeignKey('users.id'), default=uuid.uuid4)
    folder_id = Column(String, ForeignKey('folders.id'), default=uuid.uuid4)

    last_user_change = relationship('User', back_populates='folder_elements_changed')
    folder = relationship('Folder', back_populates='folder_elements')
    label_connection = relationship('FolderElementToLabel', back_populates='folder_element')

    def __init__(self, folder_name):
        self.folder_name = folder_name

    def __repr__(self):
        return "<Folder('%s')>" % self.folder_name
