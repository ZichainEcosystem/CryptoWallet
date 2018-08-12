from PyQt5.QtCore import QObject, pyqtSignal, pyqtBoundSignal, QTimer
import threading

from currencies.common import cur_dict
from utils import loger, async_func_with_callback


class Wallet(QObject):
    # declaration of signals
    transaction_completed = pyqtSignal(str, str)  # currency name and transaction result
    balance_updated = pyqtSignal(dict)  # updated balances
    address_updated = pyqtSignal(dict)  # updated addresses
    private_updated = pyqtSignal(dict)  # updated private keys
    history_updated = pyqtSignal(dict)  # updated histories
    url_address_updated = pyqtSignal(dict)  # updated url addresses
    """
    Wallet contain crypto currencies
    """
    def __init__(self, seed):
        """
        :param seed: bytes
        """
        super().__init__()
        self.seed = seed
        self.timers = []
        self.currencies = []
        # create currencies objects
        self._create_currencies()

    def __del__(self):
        pass

    def get_currency_by_name(self, currency_name):
        for item in self.currencies:
            if item.get_name() == currency_name:
                return item
        raise Exception('Currency with name %s not found', currency_name)

    def create_transaction(self, currency_name, to_address, amount):
        """
        Init transaction creating. Result will be return as transaction_completed signal
        :param currency_name: str
        :param to_address: str
        :param amount: str
        :return: None
        """
        callback = lambda transaction_status, signal_name='transaction_completed', currency_name=currency_name: \
            self.get_signal_by_name(signal_name).emit(currency_name, transaction_status)

        def sender(currency_name):
            def wrapper(to_address, amount):
                try:
                    self.get_currency_by_name(currency_name).send(to_address, float(amount))
                    return 'Success'
                except:
                    return 'Error'
            return wrapper

        async = async_func_with_callback(sender(currency_name), callback)
        async(to_address, amount)

    def get_signal_by_name(self, signal_name):
        """
        Return signal with specified name
        :param signal_name: name, str
        :return: pyqtSignal
        """
        if hasattr(self, signal_name):
            if isinstance(getattr(self, signal_name), pyqtBoundSignal):
                return getattr(self, signal_name)
        raise Exception("Signal with name %s not found" % signal_name)

    @staticmethod
    def get_currencies_names():
        """
        Return list that contain all currencies names
        :return: list
        """
        names = [x for x in cur_dict]
        return names

    @staticmethod
    def get_short_currencies_names():
        """
        Return map, for example [['Bitcoin','BTC'], ['Litecoin', 'LTC']]
        :return: list
        """
        short_names = [[x, cur_dict[x][1]] for x in cur_dict]
        return short_names
        # return [['Bitcoin','BTC'], ['Litecoin', 'LTC']]

    def _create_currencies(self):
        """
        Create ICurrency instances
        :return: None
        """
        for name in cur_dict:
            obj = cur_dict[name][0](self.seed, name, *cur_dict[name][1:])
            self.currencies.append(obj)

    def background_task_creator(self, task_name, signal_name, interval=None):
        def task():
            result = {}
            threads = []
            for item in self.currencies:
                def wrapper(currency):
                    try:
                        result[currency.get_name()] = getattr(currency, task_name)()
                    except:
                        result[currency.get_name()] = None
                thread = threading.Thread(target=wrapper, args=[item])
                thread.start()
                threads.append(thread)
            for item in threads:
                item.join()
            return result
        callback = lambda result, signal_name=signal_name: \
            self.get_signal_by_name(signal_name).emit(result)
        async_function = async_func_with_callback(task, callback)
        timer = QTimer()
        if interval is None:
            timer.setSingleShot(True)
        else:
            timer.setInterval(interval)
        timer.timeout.connect(async_function)
        timer.start()
        self.timers.append(timer)

    def start_updating(self):
        """
        Start background work
        :return: None
        """
        self.background_task_creator('get_balance', 'balance_updated', 10000)
        self.background_task_creator('get_history', 'history_updated', 10000)
        self.background_task_creator('get_address', 'address_updated')
        self.background_task_creator('get_private', 'private_updated')
        self.background_task_creator('get_url_address', 'url_address_updated')

    def stop_updating(self):
        """
        Stop background work
        :return: None
        """
        self.timers.clear()
