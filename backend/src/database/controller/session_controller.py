from sqlalchemy.orm import sessionmaker, Session

from src.database.utils import create_engine
from src.database.tables import Base, User


ENGINE = create_engine()
# Create tables
Base.metadata.create_all(ENGINE)
SESSION_MAKER = sessionmaker(bind=ENGINE)


def get_session() -> Session:
    return SESSION_MAKER()
