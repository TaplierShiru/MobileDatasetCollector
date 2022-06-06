from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware

app = None


def create_app():
    app = FastAPI()
    # Add cors
    """
    origins = [
        "http://localhost:8080",
        "http://91.222.131.127:21665"
    ]
    app.add_middleware(
        CORSMiddleware,
        allow_origins=origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    """
    from src.user.controller import auth_controller
    app.include_router(auth_controller.router)
    from src.folder.controller import folder_controller
    app.include_router(folder_controller.router)
    from src.folder.controller import folder_element_controller
    app.include_router(folder_element_controller.router)

    app.mount("/static", StaticFiles(directory="static"), name="static")
    return app


if app is None:
    app = create_app()
