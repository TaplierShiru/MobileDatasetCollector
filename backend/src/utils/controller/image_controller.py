import base64
import os
import uuid


class ImageController:
    URL_PREFIX = 'static/images'

    @staticmethod
    def save_image(decoded_str: str) -> str:
        random_uuid_str = uuid.uuid4().hex

        cur_path = os.path.dirname(os.path.realpath(__file__))
        cur_path = "\\".join(cur_path.split('\\')[:-3])  # Skip this path `src/utils/controller`
        server_folder_path = os.path.join(cur_path, ImageController.URL_PREFIX)
        prefix_save_path = os.path.join(server_folder_path, f'{random_uuid_str}.png')
        image_url = os.path.join(ImageController.URL_PREFIX, f'{random_uuid_str}.png')
        with open(prefix_save_path, 'wb') as fb:
            fb.write(base64.b64decode(decoded_str))
        return image_url
