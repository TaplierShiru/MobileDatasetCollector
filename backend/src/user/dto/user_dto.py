from pydantic import BaseModel

from src.database.tables import User


class UserDto(BaseModel):
    id: str
    firstName: str
    lastName: str
    email: str
    phone: str
    # role: str

    @staticmethod
    def from_database(user: User):
        return UserDto(
            id=user.id, firstName=user.first_name,
            lastName=user.last_name,
            email=user.email, phone=user.phone,
        )
