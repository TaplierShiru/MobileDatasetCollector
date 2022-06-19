from datetime import date
from typing import Union

from pydantic import BaseModel

from src.shared.dto import LabelDto


class FolderElementUpdateDto(BaseModel):
    name: str
    label: LabelDto
    image_file: Union[str, None]
