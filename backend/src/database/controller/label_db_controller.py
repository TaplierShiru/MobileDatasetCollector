import traceback
from typing import Union

from src.database.controller.session_controller import get_session
from src.database.tables.label import Label


class LabelDbController:

    @staticmethod
    def get_label(id: str) -> Union[Label, None]:
        try:
            with get_session() as session:
                label: Union[Label, None] = session.query(Label).filter_by(id=id).first()
                session.commit()
                return label
        except Exception as e:
            print(e)
            traceback.print_exc()
