import traceback

from src.database.controller.session_controller import get_session
from src.database.tables import Folder, FolderElement
from src.database.tables.label import Label


class LabelDbController:

    @staticmethod
    def add_label(folder: Folder, label: Label) -> bool:
        try:
            with get_session() as session:
                folder: Folder = session.query(Folder).filter_by(id=folder.id).first()
                if folder is None:
                    return False
                folder.labels.append(label)
                session.commit()
                return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def remove_label(label: Label) -> bool:
        try:
            with get_session() as session:
                label: Label = session.query(Label).filter_by(id=label.id).first()
                if label is None:
                    return False
                session.delete(label)
                session.commit()
                return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False
