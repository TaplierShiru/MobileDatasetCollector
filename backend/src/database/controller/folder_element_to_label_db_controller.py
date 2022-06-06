from typing import Union

from sqlalchemy.orm import Session

from src.database.tables import Label, FolderElement, FolderElementToLabel


class FolderElementToLabelDbController:

    @staticmethod
    def _get_connection(id: str, session: Session) -> Union[FolderElementToLabel, None]:
        return session.query(FolderElementToLabel).filter_by(id=id).first()

    @staticmethod
    def create_connection(folder_element: FolderElement, label: Label) -> FolderElementToLabel:
        connection = FolderElementToLabel()
        connection.label = label
        connection.folder_element = folder_element
        return connection

    @staticmethod
    def update_label_connection(connection_id: str, new_label: Label, session: Session) -> FolderElementToLabel:
        connection: FolderElementToLabel = FolderElementToLabelDbController._get_connection(connection_id, session)
        connection.label = new_label
        return connection
