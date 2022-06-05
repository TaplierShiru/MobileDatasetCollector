from typing import List

from pydantic import BaseModel

from src.database.tables import User, Folder
from src.folder.dto.folder_element_dto import FolderElementDto
from src.shared.dto import LabelDto


class FolderWithElementsDto(BaseModel):
    id: str
    name: str
    labels: List[LabelDto]
    elements: List[FolderElementDto]

    @staticmethod
    def from_database(folder: Folder):
        return FolderWithElementsDto(
            id=folder.id, name=folder.folder_name,
            labels=[LabelDto.from_database(label) for label in folder.labels],
            elements=[FolderElementDto.from_database(element) for element in folder.folder_elements]
        )
