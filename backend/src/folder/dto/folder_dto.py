from typing import List

from pydantic import BaseModel

from src.database.tables import Folder
from src.shared.dto import LabelDto


class FolderDto(BaseModel):
    id: str
    name: str
    labels: List[LabelDto]
    number_records: int

    @staticmethod
    def from_database(folder: Folder):
        return FolderDto(
            id=folder.id, name=folder.folder_name,
            labels=[LabelDto.from_database(label) for label in folder.labels],
            number_records=folder.folder_elements.count()
        )
