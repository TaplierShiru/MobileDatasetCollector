import uuid

from sqlalchemy import Column, String, LargeBinary, Date, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from .base import Base


class FolderElement(Base):
    __tablename__ = 'folder_elements'
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String)
    image_path = Column(String)
    date_uploaded = Column(Date)
    date_changed = Column(Date)

    last_user_change_id = Column(String, ForeignKey('users.id'))
    last_user_change = relationship('User')
    label_id = Column(String, ForeignKey('labels.id'))
    label = relationship('Label', backref='folder_elements')
    folder_id = Column(String, ForeignKey('folders.id'))
    folder = relationship('Folder')

    def __init__(self, folder_name):
        self.folder_name = folder_name

    def __repr__(self):
        return "<Folder('%s')>" % self.folder_name
