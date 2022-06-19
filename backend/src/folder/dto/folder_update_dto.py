from typing import List

from pydantic import BaseModel

from src.shared.dto import LabelUpdateDto


class FolderUpdateDto(BaseModel):
    name: str
    labels: List[LabelUpdateDto]
