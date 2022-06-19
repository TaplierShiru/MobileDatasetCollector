from pydantic import BaseModel


class LabelUpdateDto(BaseModel):
    name: str

