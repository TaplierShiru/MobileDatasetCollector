from pydantic import BaseModel


class FilterDto(BaseModel):
    search: str

