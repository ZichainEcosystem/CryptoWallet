from PyQt5.QtQml import QQmlImageProviderBase
from PyQt5.QtCore import pyqtSignal, QObject
from PyQt5.QtQuick import QQuickImageProvider
from PyQt5.QtGui import QPixmap
from pyqrcode import QRCode
from utils import bin_path, async_func_with_callback
import os


class QrCodeGenerator(QObject):
    # declaration of signals
    qrcode_generated = pyqtSignal(str)  # currency name

    def __init__(self):
        super().__init__()
        self.provider = QrCodeProvider()

    def get_provider(self):
        return self.provider

    def generate_qrcode(self, url_links):
        for item in url_links:
            callback = lambda currency_name: \
                self.qrcode_generated.emit(currency_name)

            async = async_func_with_callback(self.provider.generate_qrcode, callback)
            async(item, url_links[item])


class QrCodeProvider(QQuickImageProvider):
    def __init__(self):
        super().__init__(QQmlImageProviderBase.Image)
        self.qrcode_cash = {}

    def requestImage(self, p_str, QSize):
        img = self.qrcode_cash[p_str]
        return img, img.size()

    def generate_qrcode(self, currency_name, url_link):
        img = QRCode(url_link)
        file_name = os.path.join(bin_path(), currency_name + '.png')
        img.png(file_name)
        pixmap = QPixmap(file_name)
        pixmap = pixmap.scaled(256, 256)
        pixmap.save(file_name)
        self.qrcode_cash[currency_name] = pixmap.toImage()
        return currency_name
