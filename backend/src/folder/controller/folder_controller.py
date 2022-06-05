from typing import Union, List

from fastapi import APIRouter
from starlette import status
from starlette.responses import Response

from src.database.controller.folder_db_controller import FolderDbController
from src.folder.dto.folder_dto import FolderDto
from src.folder.dto.folder_update_dto import FolderUpdateDto
from src.folder.dto.folder_with_elements_dto import FolderWithElementsDto
from src.database.tables import User, Folder
from src.utils.dto import FilterDto

router = APIRouter(
    prefix='/folders',
    tags=['folders'],
    responses={404: {'description': 'Not found'}},
)


@router.post('/all', response_model=List[FolderDto], status_code=status.HTTP_200_OK)
async def register(filter_dto: FilterDto):
    folders: List[FolderDto] = FolderDbController.get_all_folders(filter_dto)
    return folders


@router.post("/", response_model=FolderDto, status_code=status.HTTP_201_CREATED)
async def create_folder(folder_update_dto: FolderUpdateDto, response: Response):
    folder: Union[FolderDto, None] = FolderDbController.add_folder(folder_update_dto)
    if folder:
        return folder
    response.status_code = status.HTTP_404_NOT_FOUND


@router.put("/{id}", response_model=FolderDto, status_code=status.HTTP_200_OK)
async def update_folder(id: str, folder_update_dto: FolderUpdateDto, response: Response):
    folder: Union[Folder, None] = FolderDbController.update_folder(id, folder_update_dto)
    if folder:
        return folder
    response.status_code = status.HTTP_404_NOT_FOUND


@router.get("/{id}", response_model=FolderWithElementsDto, status_code=status.HTTP_200_OK)
async def update_folder(id: str, response: Response):
    folder: Union[FolderWithElementsDto, None] = FolderDbController.get_folder_with_elements(id)
    if folder:
        return folder
    response.status_code = status.HTTP_404_NOT_FOUND


@router.delete("/{id}", status_code=status.HTTP_200_OK)
async def update_folder(id: str, response: Response):
    return FolderDbController.remove_folder(id)
