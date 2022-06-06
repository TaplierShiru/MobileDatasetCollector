import os
import traceback

import sqlalchemy
from sqlalchemy.exc import ProgrammingError


def create_database(name: str, echo: bool = False) -> bool:
    if os.environ.get("DB_URL") is not None:
        db_url = os.environ['DB_URL']
    else:
        raise ValueError(f"Error! Try to create database with name={name} in debug mode.")

    try:
        engine = sqlalchemy.create_engine(
            db_url, echo=echo
        )
        engine.execute(f"CREATE DATABASE {name}")
        engine.execute(f"USE {name}")
        return True
    except ProgrammingError as e:
        # Db already exist, just return False
        return False
    except Exception as e:
        print(e)
        traceback.print_exc()


