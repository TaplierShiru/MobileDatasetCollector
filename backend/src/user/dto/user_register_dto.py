
from pydantic import BaseModel


class UserRegisterDto(BaseModel):
    firstName: str
    lastName: str
    email: str
    password: str
    phone: str
