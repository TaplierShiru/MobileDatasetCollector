import traceback
from typing import List, Union

from src.database.controller.session_controller import get_session
from src.database.tables import Folder


class FolderDbController:

    @staticmethod
    def get_folder(folder: Folder) -> Union[Folder, None]:
        try:
            with get_session() as session:
                folder: Folder = session.query(Folder).filter_by(id=folder.id).first()
                return folder
        except Exception as e:
            print(e)
            traceback.print_exc()

    @staticmethod
    def add_folder(folder: Folder) -> bool:
        try:
            with get_session() as session:
                session.add(folder)
                session.commit()
                return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def remove_folder(folder: Folder) -> bool:
        try:
            with get_session() as session:
                folder: Folder = session.query(Folder).filter_by(id=folder.id).first()
                if folder is None:
                    return False
                session.delete(folder)
                session.commit()
                return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def get_all_folders() -> List[Folder]:
        try:
            with get_session() as session:
                folder_list: List[Folder] = session.query(Folder).all()
                return folder_list
        except Exception as e:
            print(e)
            traceback.print_exc()
