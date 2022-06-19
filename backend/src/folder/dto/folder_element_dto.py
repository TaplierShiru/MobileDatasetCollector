from datetime import date

from pydantic import BaseModel

from src.database.tables import FolderElement
from src.shared.dto import LabelDto
from src.user.dto.user_dto import UserDto


class FolderElementDto(BaseModel):
    id: str
    name: str
    label: LabelDto
    image_url: str
    date_uploaded: date
    date_changed: date
    last_user_change: UserDto

    @staticmethod
    def from_database(folder_element: FolderElement):
        return FolderElementDto(
            id=folder_element.id, name=folder_element.name,
            label=LabelDto.from_database(folder_element.label_connection.label),
            image_url=folder_element.image_path,
            date_uploaded=folder_element.date_uploaded,
            date_changed=folder_element.date_changed,
            last_user_change=UserDto.from_database(folder_element.last_user_change)
        )
