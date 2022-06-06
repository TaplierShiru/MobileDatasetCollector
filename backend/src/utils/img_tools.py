import base64
from io import BytesIO

from PIL import Image


def image2base64(img_path: str):
    img = Image.open(img_path)
    im_file = BytesIO()
    img.save(im_file, format="JPEG")
    im_bytes = im_file.getvalue()
    im_b64 = base64.b64encode(im_bytes)
    return im_b64
