from datetime import datetime, timedelta
from typing import Optional, Union

from fastapi import HTTPException
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from jose import jwt, JWTError
from starlette import status
from starlette.requests import Request

from src.database import UserDbController
from src.user.dto import UserDto


class JWTBearer(HTTPBearer):
    # to get a string like this run:
    # openssl rand -hex 32
    SECRET_KEY = "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"
    ALGORITHM = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES = 30

    def __init__(self, auto_error: bool = True):
        super().__init__(auto_error=auto_error)

    async def __call__(self, request: Request):
        credentials: HTTPAuthorizationCredentials = await super(JWTBearer, self).__call__(request)
        if credentials:
            if not credentials.scheme == "Bearer":
                raise HTTPException(status_code=403, detail="Invalid authentication scheme.")
            email: str = JWTBearer.get_data_from_payload(self.verify_jwt_token(credentials.credentials))
            user: Union[UserDto, None] = UserDbController.get_user(email)
            if user is None:
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    detail="Could not validate credentials",
                    headers={"WWW-Authenticate": "Bearer"},
                )
            return user
        else:
            raise HTTPException(status_code=403, detail="Invalid authorization code.")

    def verify_jwt_token(self, token: str) -> Optional[dict]:
        credentials_exception = HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
        try:
            payload = JWTBearer.jwt_decode(token)
            data = payload.get("sub")
            if data is None:
                raise credentials_exception
            return payload
        except jwt.ExpiredSignatureError:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token has been expired",
                headers={"WWW-Authenticate": "Bearer"},
            )
        except JWTError:
            raise credentials_exception

    @staticmethod
    def jwt_decode(token: str) -> Optional[dict]:
        payload = jwt.decode(token, JWTBearer.SECRET_KEY, algorithms=[JWTBearer.ALGORITHM])
        return payload

    @staticmethod
    def get_data_from_payload(payload: dict) -> str:
        return payload.get('sub')

    @staticmethod
    def create_access_token(data: dict, expires_delta: Union[timedelta, None] = None):
        to_encode = data.copy()
        if expires_delta:
            expire = datetime.utcnow() + expires_delta
        else:
            expire = datetime.utcnow() + timedelta(minutes=15)
        to_encode.update({"exp": expire})
        encoded_jwt = jwt.encode(to_encode, JWTBearer.SECRET_KEY, algorithm=JWTBearer.ALGORITHM)
        return encoded_jwt
