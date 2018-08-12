from PyQt5.QtQuick import QQuickView
from PyQt5 import QtGui, QtQuick, QtCore
import os
import pickle
import time

from utils import loger, bin_path
from coinindexparser import IndexParser
from wallet_manager import WalletManager
from wallet import Wallet
from qrcodegenerator import QrCodeGenerator


class Application(QQuickView):
    def __init__(self, title, qml_path, icon_path):
        super().__init__()
        self.engine().addImportPath(qml_path)
        self.setIcon(QtGui.QIcon(icon_path))
        self.setResizeMode(QtQuick.QQuickView.SizeRootObjectToView)
        self.setTitle(title)
        self.setMinimumSize(QtCore.QSize(1100, 740))
        self.init_pallete()
        self.init_fonts()
        self.qml_path = qml_path
        self.qml_children = {}
        self.qrcode_generator = QrCodeGenerator()
        self.engine().addImageProvider("qrcode_provider", self.qrcode_generator.get_provider())
        self.index_parser = IndexParser()

    def setSource(self, main):
        main_path = os.path.join(self.qml_path, main)
        super().setSource(QtCore.QUrl.fromLocalFile(main_path))

    def init_pallete(self):
        primary_colors = (
            "#673AB7", "#EDE7F6", "#D1C4E9", "#B39DDB", "#9575CD",
            "#7E57C2", "#673AB7", "#5E35B1", "#512DA8", "#4527A0",
            "#311B92", "#B388FF", "#7C4DFF", "#651FFF"
        )
        secondary_colors = (
            "#fce4ec", "#f8bbd0", "#f48fb1", "#f06292", "#ec407a",
            "#e91e63", "#d81b60", "#c2185b", "#ad1457", "#880e4f",
            "#ff80ab", "#ff4081", "#f50057", "#c51162"
        )
        grey_colors = (
            "#fafafa", "#f5f5f5", "#eeeeee", "#e0e0e0", "#bdbdbd",
            "#9e9e9e", "#757575", "#616161", "#424242", "#212121",
            "#ff00ff", "#ff00ff", "#ff00ff", "#ff00ff"
        )
        self.add_pallete("p1", primary_colors)
        self.add_pallete("p2", secondary_colors)
        self.add_pallete("p", grey_colors)

    def init_fonts(self):
        app_fonts = QtGui.QFontDatabase()
        app_fonts.addApplicationFont(
            ":/material/fonts/roboto/Roboto-Regular.ttf")
        app_fonts.addApplicationFont(
            ":/material/fonts/roboto/Roboto-Light.ttf")
        app_fonts.addApplicationFont(
            ":/material/fonts/roboto/Roboto-Medium.ttf")

    def add_pallete(self, prefix, colors):
        ctxt = self.rootContext()
        names = (
            "50",
            "100",
            "200",
            "300",
            "400",
            "500",
            "600",
            "700",
            "800",
            "900",
            "a100",
            "a200",
            "a400",
            "a700")
        for n, val in enumerate(colors):
            ctxt.setContextProperty(prefix + "_" + names[n], val)

    def copy_to_clipboard(self, data):
        QtGui.QGuiApplication.clipboard().setText(data)

    def child(self, name):
        if name in self.qml_children:
            return self.qml_children[name]
        res = self.findChild(QtCore.QObject, name)
        self.qml_children[name] = res
        return res

    def setup_gui_and_connect_base_signals(self):
        self.child('signUpParent').signUpWallet.connect(self.wallet_signup)
        self.child('signInParent').logInWallet.connect(self.wallet_signin)
        self.child('clipboard').copyToClipboard.connect(self.copy_to_clipboard)
        self.child('settings').setInGUI.connect(self.set_visible_currency)
        self.child('converter').setInGUI.connect(self.set_visible_fiat_currency)
        self.child('objectmanager').createCurrencyObjects(Wallet.get_short_currencies_names())
        self.child('settings').setCurrencyList(Wallet.get_short_currencies_names())
        self.child('privmanager').createPrivateObjects()
        self.child('historymanager').createHistoryObjects()
        self.child('stats').fillChart()
        self.qrcode_generator.qrcode_generated.connect(self.set_qrcode)
        self.index_parser.index_parsed.connect(self.set_courses)
        self.index_parser.start_parsing(Wallet.get_currencies_names())

    def save_state(self):
        wallet_list = self.child('settings').getEnabledCurrency().toVariant()
        fiat_list = self.child('converter').getEnabledCurrency().toVariant()
        for_dump = {'wallet_list': wallet_list, 'fiat_list': fiat_list}
        with open(os.path.join(bin_path(), 'lastlist'), 'wb') as fp:
            pickle.dump(for_dump, fp)

    def load_state(self):
        try:
            with open(os.path.join(bin_path(), 'lastlist'), 'rb') as fp:
                loaded_dump = pickle.load(fp)
        except:
            loaded_dump = {'wallet_list': Wallet.get_currencies_names(),
                           'fiat_list': ['USD', 'EUR', 'RUB']}
        self.child('settings').loadList(loaded_dump['wallet_list'])
        self.child('converter').loadList(loaded_dump['fiat_list'])

    def wallet_signup(self, total, required, tg_id):
        keys = WalletManager.sign_up(total, required)
        self.child('signUpParent').setPrivateKeys(keys)
        self.prepare_wallet()

    def wallet_signin(self, keys):
        keys = keys.toVariant()
        try:
            WalletManager.sign_in(keys)
            self.child('signInParent').callback(True)
            self.prepare_wallet()
        except:
            self.child('signInParent').callback(False)

    def prepare_wallet(self):
        WalletManager.get_wallet().get_signal_by_name('balance_updated').connect(self.set_balance)
        WalletManager.get_wallet().get_signal_by_name('address_updated').connect(self.set_address)
        WalletManager.get_wallet().get_signal_by_name('history_updated').connect(self.set_history)
        WalletManager.get_wallet().get_signal_by_name('private_updated').connect(self.set_private)
        WalletManager.get_wallet().get_signal_by_name('url_address_updated').connect(self.set_url_address)
        WalletManager.get_wallet().get_signal_by_name('url_address_updated').connect(self.qrcode_generator.generate_qrcode)
        self.child('objectholder').sendTransaction.connect(WalletManager.get_wallet().create_transaction)
        WalletManager.get_wallet().get_signal_by_name('transaction_completed').connect(self.set_transaction_result)

    def set_visible_currency(self, currency_list):
        self.child('objectmanager').setCurrency(currency_list)
        self.child('privmanager').setCurrency(currency_list)
        self.child('historymanager').setCurrency(currency_list)

    def set_visible_fiat_currency(self, fiat_currency_list):
        for item in self.findChildren(QtCore.QObject, "currencybox"):
            item.setList(fiat_currency_list)
        self.child('totalbalancebox').setList(fiat_currency_list)

    def set_balance(self, balances):
        for item in balances:
            self.child(item).setBalance(balances[item])

    def set_history(self, histories):
        def history_to_dict(history):
            result = dict()
            result['day'] = time.strftime("%b %d %Y", time.gmtime(history.ts))
            result['hour'] = time.strftime("%H:%M", time.gmtime(history.ts))
            result['change'] = history.change + ' ' + history.name
            return result

        for item in histories:
            if histories[item] is not None:
                self.child('history' + item).updateHistory([history_to_dict(x) for x in histories[item]])

    def set_address(self, addresses):
        for item in addresses:
            self.child(item).setAddress(addresses[item])

    def set_url_address(self, url_addresses):
        for item in url_addresses:
            self.child(item).setUrlAddress(url_addresses[item])

    def set_private(self, privates):
        for item in privates:
            self.child(item).setPrivateKey(privates[item])

    def set_transaction_result(self, currency_name, result):
        self.child(currency_name).transactionResult(result)

    def set_qrcode(self, currency_name):
        self.child(currency_name).updateQrCode('image://qrcode_provider/%s' % currency_name)

    def set_courses(self, courses):
        for currency_name in courses:
            self.child(currency_name).setCourses(courses[currency_name])