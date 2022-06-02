import traceback
from typing import List, Union

from src.database.controller.session_controller import get_session
from src.database.tables import Folder, FolderElement


class FolderElementDbController:

    @staticmethod
    def get_folder_element(folder_element: FolderElement) -> Union[FolderElement, None]:
        try:
            with get_session() as session:
                folder_element: FolderElement = session.query(FolderElement).filter_by(id=folder_element.id).first()
                return folder_element
        except Exception as e:
            print(e)
            traceback.print_exc()

    @staticmethod
    def update_folder_element(old_folder_element: FolderElement, new_folder_element: FolderElement) -> bool:
        try:
            with get_session() as session:
                folder_element: FolderElement = session.query(FolderElement).filter_by(id=old_folder_element.id).first()
                if folder_element is None:
                    return False
                # Update fields
                folder_element.name = new_folder_element.name
                folder_element.image_path = new_folder_element.image_path
                folder_element.date_uploaded = new_folder_element.date_uploaded
                folder_element.date_changed = new_folder_element.date_changed
                folder_element.last_user_change = new_folder_element.last_user_change
                folder_element.label = new_folder_element.label
                session.commit()
                return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def add_folder_element(folder: Folder, folder_element: FolderElement) -> bool:
        try:
            with get_session() as session:
                folder: Folder = session.query(Folder).filter_by(id=folder.id).first()
                if folder is None:
                    return False
                folder.folder_elements.append(folder_element)
                session.commit()
                return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

    @staticmethod
    def remove_folder_element(folder_element: FolderElement) -> bool:
        try:
            with get_session() as session:
                folder_element: FolderElement = session.query(FolderElement).filter_by(id=folder_element.id).first()
                if folder_element is None:
                    return False
                session.delete(folder_element)
                session.commit()
                return True
        except Exception as e:
            print(e)
            traceback.print_exc()
        return False

