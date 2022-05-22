from fastapi import APIRouter

router = APIRouter(
    prefix='/auth',
    tags=['auth'],
    responses={404: {'description': 'Not found'}},
)


@router.get("/")
async def root():
    return {"message": "Hello World"}


@router.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}

