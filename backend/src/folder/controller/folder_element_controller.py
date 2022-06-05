from typing import List, Union

from starlette import status
from starlette.responses import Response

from .folder_controller import router
from ..dto.folder_dto import FolderDto
from ..dto.folder_element_dto import FolderElementDto
from ..dto.folder_element_update_dto import FolderElementUpdateDto
from ...database.controller.folder_element_db_controller import FolderElementDbController
from ...utils.dto import FilterDto


@router.post('/{id}/folder-elements/all', response_model=List[FolderDto], status_code=status.HTTP_200_OK)
async def register(id: str, filter_dto: FilterDto):
    return FolderElementDbController.get_all_folder_elements(id, filter_dto)


@router.post("/{id}/folder-elements/{element_id}", response_model=FolderElementDto, status_code=status.HTTP_201_CREATED)
async def create_folder(
        id: str, element_id: str,
        folder_element_update_dto: FolderElementUpdateDto, response: Response):
    folder_element: Union[FolderElementDto, None] = FolderElementDbController.add_folder_element(
        id, folder_element_update_dto
    )
    if folder_element:
        return folder_element
    response.status_code = status.HTTP_404_NOT_FOUND


@router.put("/{id}/folder-elements/{element_id}", response_model=FolderElementDto, status_code=status.HTTP_200_OK)
async def update_folder(
        id: str, element_id: str,
        folder_element_update_dto: FolderElementUpdateDto, response: Response):
    folder_element: Union[FolderElementDto, None] = FolderElementDbController.update_folder_element(
        id, folder_element_update_dto
    )
    if folder_element:
        return folder_element
    response.status_code = status.HTTP_404_NOT_FOUND


@router.get("/{id}/folder-elements/{element_id}", response_model=FolderElementDto, status_code=status.HTTP_200_OK)
async def update_folder(id: str, element_id: str, response: Response):
    folder_element: Union[FolderElementDto, None] = FolderElementDbController.get_folder_element(id)
    if folder_element:
        return folder_element
    response.status_code = status.HTTP_404_NOT_FOUND


@router.delete("/{id}/folder-elements/{element_id}", status_code=status.HTTP_200_OK)
async def update_folder(id: str, element_id: str, response: Response):
    return FolderElementDbController.remove_folder_element(id)

