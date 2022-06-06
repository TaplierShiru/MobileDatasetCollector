import hashlib
import os
from typing import Tuple

from .constants import N, P, R, SALT_LEN, PASSWORD_LEN


def get_hash(password: str, salt: bytes = None) -> Tuple[bytes, bytes]:
    """
    Return hash and salt

    """
    if salt is None:
        salt = os.urandom(SALT_LEN)
    return hashlib.scrypt(
        password=password.encode(), # To bytes
        salt=salt,
        n=N, r=R, p=P, dklen=PASSWORD_LEN,
    ), salt
