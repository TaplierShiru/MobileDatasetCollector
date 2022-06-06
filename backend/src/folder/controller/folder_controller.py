from typing import Union, List

from fastapi import APIRouter, HTTPException
from starlette import status
from starlette.responses import Response

from src.database.controller import FolderDbController
from src.database.tables import Folder
from src.folder.dto.folder_dto import FolderDto
from src.folder.dto.folder_update_dto import FolderUpdateDto
from src.utils.dto import FilterDto

router = APIRouter(
    prefix='/folders',
    tags=['folders'],
    responses={404: {'description': 'Not found'}},
)


@router.post('/all', response_model=List[FolderDto], status_code=status.HTTP_200_OK)
async def get_all(filter_dto: FilterDto):
    folders: List[FolderDto] = FolderDbController.get_all_folders(filter_dto)
    return folders


@router.post("/", response_model=FolderDto, status_code=status.HTTP_201_CREATED)
async def create_folder(folder_update_dto: FolderUpdateDto, response: Response):
    folder: Union[FolderDto, None] = FolderDbController.add_folder(folder_update_dto)
    if folder:
        return folder
    raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Folder can't be created")


@router.put("/{id}", response_model=FolderDto, status_code=status.HTTP_200_OK)
async def update_folder(id: str, folder_update_dto: FolderUpdateDto, response: Response):
    folder: Union[Folder, None] = FolderDbController.update_folder(id, folder_update_dto)
    if folder:
        return folder
    raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Folder can't be updated")


@router.get("/{id}", response_model=FolderDto, status_code=status.HTTP_200_OK)
async def get_folder(id: str, response: Response):
    folder: Union[FolderDto, None] = FolderDbController.get_folder(id)
    if folder:
        return folder
    raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Folder can't be returned")


@router.delete("/{id}", status_code=status.HTTP_200_OK)
async def delete_folder(id: str, response: Response):
    return FolderDbController.remove_folder(id)

