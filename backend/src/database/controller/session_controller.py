from sqlalchemy.orm import sessionmaker, Session

from src.database.tables import Base
from src.database.utils import create_engine

ENGINE = create_engine()
# Create tables
Base.metadata.create_all(ENGINE)
SESSION_MAKER = sessionmaker(bind=ENGINE, expire_on_commit=False)


def get_session() -> Session:
    return SESSION_MAKER()
