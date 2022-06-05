from datetime import date
from typing import Union

from pydantic import BaseModel

from src.shared.dto import LabelDto
from src.user.dto.user_dto import UserDto


class FolderElementUpdateDto(BaseModel):
    name: str
    label: LabelDto
    image_file: Union[str, None]
    date_uploaded: date
    date_changed: date
    last_user_change: UserDto
