import os
import sqlalchemy
from sqlalchemy.engine.mock import MockConnection

from .constants import DATABASE_NAME
from .create_database import create_database


def create_engine(db_url: str = None) -> MockConnection:
    if db_url is None:
        if os.environ.get("DB_URL") is not None:
            db_url = os.environ['DB_URL'] + f'/{DATABASE_NAME}'
            echo = False
            # Check if database created, in this case sqlalchemy does not create
            # database on it own, we should check by ourself it
            create_database(DATABASE_NAME)
        else:
            cur_path = os.path.dirname(os.path.realpath(__file__))
            cur_path = "\\".join(cur_path.split('\\')[:-3]) # Skip this path `src/database/utils`
            db_url = f'sqlite:///{cur_path}/static/database/debug_db/debug_db.db'
            print(db_url)
            echo = True

    return sqlalchemy.create_engine(db_url, echo=echo)