import traceback
from typing import List, Union

from sqlalchemy.orm import Session

from src.database.controller.label_db_controller import LabelDbController
from src.database.controller.session_controller import get_session
from src.database.tables import Folder, Label
from src.folder.dto import FolderDto
from src.folder.dto import FolderUpdateDto
from src.utils import log
from src.utils.dto import FilterDto


class FolderDbController:

    @staticmethod
    def get_folder(id: str) -> Union[FolderDto, None]:
        try:
            with get_session() as session:
                folder: Union[Folder, None] = FolderDbController.get_folder_with_session(id, session)
                if folder is None:
                    return
                return FolderDto.from_database(folder)
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def get_folder_with_session(id: str, session: Session) -> Union[Folder, None]:
        return session.query(Folder).filter_by(id=id).first()

    @staticmethod
    def add_folder(folder_update_dto: FolderUpdateDto) -> Union[FolderDto, None]:
        try:
            with get_session() as session:
                # Create each label
                created_labels = []
                for label_single in folder_update_dto.labels:
                    created_labels.append(Label(label_single.name))
                folder = Folder(folder_update_dto.name)
                folder.labels = created_labels
                session.add(folder)
                session.commit()
                return FolderDto.from_database(folder)
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def update_folder(id: str, folder_update_dto: FolderUpdateDto) -> Union[FolderDto, None]:
        try:
            with get_session() as session:
                folder: Union[Folder, None] = FolderDbController.get_folder_with_session(id, session)
                if folder is None:
                    return
                # Check each label
                updated_labels = []
                for label_single in folder_update_dto.labels:
                    if label_single.id is not None:
                        # Take existed label and update parameters
                        found_label = LabelDbController.get_label(label_single.id)
                        # Only if its exist
                        if found_label is not None:
                            found_label.label_name = label_single.name
                            updated_labels.append(found_label)
                            continue
                    # Create label
                    updated_labels.append(Label(label_single.name))
                folder.folder_name = folder_update_dto.name
                folder.labels = updated_labels
                session.commit()
                return FolderDto.from_database(folder)
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def remove_folder(id: str) -> bool:
        try:
            with get_session() as session:
                folder: Folder = FolderDbController.get_folder_with_session(id, session)
                if folder is None:
                    return False
                session.delete(folder)
                session.commit()
                return True
        except Exception as e:
            log.debug(e)
            traceback.print_exc()
        return False

    @staticmethod
    def get_all_folders(filter_dto: FilterDto) -> List[FolderDto]:
        try:
            with get_session() as session:
                folder_list: List[Folder] = session.query(Folder).filter(
                    Folder.folder_name.like(f'%{filter_dto.search}%')
                ).all()
                folders = [FolderDto.from_database(folder) for folder in folder_list]
                return folders
        except Exception as e:
            log.debug(e)
            traceback.print_exc()
