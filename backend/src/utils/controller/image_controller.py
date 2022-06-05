import base64
import os
import uuid


class ImageController:

    SAVE_PATH = 'src/static/images'
    URL_PREFIX = '/static/images'

    @staticmethod
    def save_image(decoded_str: str) -> str:
        random_uuid_str = uuid.uuid4().hex
        prefix_save_path = os.path.join(ImageController.SAVE_PATH, f'{random_uuid_str}.png')
        image_url = os.path.join(ImageController.URL_PREFIX, f'{random_uuid_str}.png')
        with open(prefix_save_path, 'wb') as fb:
            fb.write(base64.b64decode(decoded_str))
        return image_url
