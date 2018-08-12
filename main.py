from PyQt5.QtWidgets import QApplication
import sys
import os

import utils
from app import Application


if __name__ == "__main__":
    icon_path = os.path.join(utils.root_path(), 'icons', 'appicon.png')
    app = QApplication(sys.argv)
    window = Application('DCG', utils.qml_path(), icon_path)
    window.setSource('main.qml')
    window.setup_gui_and_connect_base_signals()
    window.load_state()
    window.show()
    app.exec()
    window.save_state()