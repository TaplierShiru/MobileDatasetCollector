from typing import List, Union

from fastapi import HTTPException, APIRouter
from starlette import status

from ..dto.folder_dto import FolderDto
from ..dto.folder_element_dto import FolderElementDto
from ..dto.folder_element_update_dto import FolderElementUpdateDto
from ...database.controller.folder_element_db_controller import FolderElementDbController
from ...utils.dto import FilterDto

router = APIRouter(
    prefix='/folders',
    tags=['folder_elements'],
    responses={404: {'description': 'Not found'}},
)


@router.post('/{id}/folder-elements/all', response_model=List[FolderDto], status_code=status.HTTP_200_OK)
async def get_all(id: str, filter_dto: FilterDto):
    return FolderElementDbController.get_all_folder_elements(id, filter_dto)


@router.post("/{id}/folder-elements", response_model=FolderElementDto, status_code=status.HTTP_201_CREATED)
async def create_folder_element(
        id: str,
        folder_element_update_dto: FolderElementUpdateDto):
    folder_element: Union[FolderElementDto, None] = FolderElementDbController.add_folder_element(
        id, folder_element_update_dto
    )
    if folder_element:
        return folder_element
    raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Folder element can't be created")


@router.put("/{id}/folder-elements/{element_id}", response_model=FolderElementDto, status_code=status.HTTP_200_OK)
async def update_folder_element(
        id: str, element_id: str,
        folder_element_update_dto: FolderElementUpdateDto):
    folder_element: Union[FolderElementDto, None] = FolderElementDbController.update_folder_element(
        id, folder_element_update_dto
    )
    if folder_element:
        return folder_element
    raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Folder element can't be updated")


@router.get("/{id}/folder-elements/{element_id}", response_model=FolderElementDto, status_code=status.HTTP_200_OK)
async def get_folder_element(id: str, element_id: str):
    folder_element: Union[FolderElementDto, None] = FolderElementDbController.get_folder_element(id)
    if folder_element:
        return folder_element
    raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Folder element can't be returned")


@router.delete("/{id}/folder-elements/{element_id}", status_code=status.HTTP_200_OK)
async def delete_folder_element(id: str, element_id: str):
    return FolderElementDbController.remove_folder_element(id)

