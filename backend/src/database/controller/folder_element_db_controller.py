import datetime
import traceback
from typing import List, Union

from sqlalchemy.orm import Session

from src.database.controller.folder_db_controller import FolderDbController
from src.database.controller.folder_element_to_label_db_controller import FolderElementToLabelDbController
from src.database.controller.label_db_controller import LabelDbController
from src.database.controller.session_controller import get_session
from src.database.controller.user_db_controller import UserDbController
from src.database.tables import Folder, FolderElement
from src.folder.dto.folder_element_dto import FolderElementDto
from src.folder.dto.folder_element_update_dto import FolderElementUpdateDto
from src.user.dto import UserDto
from src.utils import log
from src.utils.controller import ImageController
from src.utils.dto import FilterDto


class FolderElementDbController:

    @staticmethod
    def get_folder_element(id: str) -> Union[FolderElementDto, None]:
        try:
            with get_session() as session:
                folder_element: Union[FolderElement, None] = FolderElementDbController._get_folder_element(id, session)
                if folder_element is None:
                    return
                return FolderElementDto.from_database(folder_element)
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def _get_folder_element(id: str, session: Session) -> Union[FolderElement, None]:
        return session.query(FolderElement).filter_by(id=id).first()

    @staticmethod
    def add_folder_element(
            parent_id: str,
            folder_element_update_dto: FolderElementUpdateDto,
            user_created: UserDto) -> Union[FolderElementDto, None]:
        try:
            with get_session() as session:
                folder: Union[Folder, None] = FolderDbController.get_folder_with_session(parent_id, session)
                if folder is None:
                    return
                new_folder_element = FolderElement(folder_element_update_dto.name)
                if folder_element_update_dto.image_file is not None:
                    new_folder_element.image_path = ImageController.save_image(folder_element_update_dto.image_file)
                new_folder_element.date_uploaded = datetime.date.today()
                new_folder_element.date_changed = datetime.date.today()
                new_folder_element.last_user_change = UserDbController.get_user_with_session(
                    session, user_created.id
                )

                label = LabelDbController.get_label(folder_element_update_dto.label.id)
                new_folder_element.label_connection = FolderElementToLabelDbController.create_connection(
                    new_folder_element, label
                )

                folder.folder_elements.append(new_folder_element)
                session.commit()
                folderElementDto = FolderElementDto.from_database(new_folder_element)
                return folderElementDto
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def update_folder_element(
            id: str,
            folder_element_update_dto: FolderElementUpdateDto,
            user_updated: UserDto) -> Union[FolderElementDto, None]:
        try:
            with get_session() as session:
                folder_element: FolderElement = FolderElementDbController._get_folder_element(id, session)
                if folder_element is None:
                    return
                # Update fields
                folder_element.name = folder_element_update_dto.name
                if folder_element_update_dto.image_file is not None:
                    # TODO: delete old images
                    folder_element.image_path = ImageController.save_image(folder_element_update_dto.image_file)
                folder_element.date_changed = datetime.date.today()
                folder_element.last_user_change = UserDbController.get_user_with_session(
                    session, user_updated.id
                )

                label = LabelDbController.get_label(folder_element_update_dto.label.id)
                FolderElementToLabelDbController.update_label_connection(
                    folder_element.label_connection.id,
                    label, session
                )
                session.commit()
                folder_element_dto = FolderElementDto.from_database(folder_element)
                return folder_element_dto
        except Exception as e:
            log.debug(e)
            traceback.print_exc()

    @staticmethod
    def remove_folder_element(id: str) -> bool:
        try:
            with get_session() as session:
                folder_element: FolderElement = FolderElementDbController._get_folder_element(id)
                if folder_element is None:
                    return False
                session.delete(folder_element)
                session.commit()
                return True
        except Exception as e:
            log.debug(e)
            traceback.print_exc()
        return False

    @staticmethod
    def get_all_folder_elements(parent_id: str, filter_dto: FilterDto) -> Union[List[FolderElementDto], None]:
        try:
            with get_session() as session:
                folder: Union[Folder, None] = FolderDbController.get_folder_with_session(parent_id, session)
                if folder is None:
                    return
                folder_elements = folder.folder_elements.filter(
                    FolderElement.name.like(f'%{filter_dto.search}%')
                ).all()
                print(len(folder_elements), ' !!!!!!!!!!!!!!!!!!!!!!!!!')
                folder_elements = [
                    FolderElementDto.from_database(folder_element)
                    for folder_element in folder_elements
                ]
                print(len(folder_elements), ' !!!!!!!!!!!!!!!!!!!!!!!!!')
                return folder_elements
        except Exception as e:
            log.debug(e)
            traceback.print_exc()
