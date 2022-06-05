from typing import List

from pydantic import BaseModel

from src.shared.dto import LabelDto


class FolderUpdateDto(BaseModel):
    name: str
    labels: List[LabelDto]
