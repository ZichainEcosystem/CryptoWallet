from currencies.api import Api
from utils import loger
import time


class TxInfo:
    def __init__(self, txid, timestamp, change, short_name):
        """
        :param txid: txid, str
        :param timestamp: epoch, int
        :param change: summary balance change, str
        :param short_name: currency short name, str
        """
        self.txid = txid
        self.ts = timestamp
        self.change = change
        self.name = short_name


class ICurrency:
    """
    Interface for crypto currencies
    """
    def __init__(self, seed, name, short_name):
        """
        :param name: full name, str
        :param short_name: short name, str
        :param seed: bytes
        """
        self.name = name
        self.short_name = short_name
        self.seed = seed

    def get_name(self):
        return self.name

    def get_short_name(self):
        return self.short_name

    def send(self, to_address, amount):
        """
        Send amount of coin to destination address and return txid
        :param to_address: destination address, str
        :param amount: amount, float
        :return: txid, str
        """
        pass

    def get_balance(self):
        """
        Return last balance
        :return: balance, float
        """
        pass

    def get_address(self):
        """
        Return address
        :return: address, str
        """
        pass

    def get_private(self):
        """
        Return private key
        :return: private, str
        """
        pass

    def get_url_address(self):
        """
        Return link to chain explorer page, that associated with this address
        :return: urt link, str
        """
        pass

    def get_history(self):
        """
        Return transaction history
        :return: array of TxInfo, list
        """
        pass

    def cleanup(self):
        """
        Stop working
        :return: None
        """
        pass


class ApiCurrency(ICurrency):
    def __init__(self, seed, name, short_name, url_link):
        super().__init__(seed, name, short_name)
        self.api = Api('http://89.207.223.140:2341')
        self.url_link = url_link

    def get_balance(self):
        return self.api.get_balance(self.get_short_name(), self.get_address())

    def get_history(self):
        history = self.api.get_history(self.get_short_name(), self.get_address())
        history.sort(key=lambda item: item['ts'], reverse=True)
        result = list()
        for item in history:
            result.append(TxInfo(item['hash'],
                                 item['ts'],
                                 str(item['amount']),
                                 self.get_short_name()))
        return result

    def get_url_address(self):
        return self.url_link % self.get_address()
