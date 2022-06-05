from pydantic import BaseModel

from src.database.tables import Label


class LabelDto(BaseModel):
    id: str
    name: str

    @staticmethod
    def from_database(label: Label):
        return LabelDto(
            id=label.id, name=label.label_name,
        )
