from PyQt5.QtCore import QObject, pyqtSignal
import requests
from utils import async_func_with_callback


WorldIndex_API_KEY = 'yNBaVci1zD5qb1HpxcEmw3Uvp15GHK'


def get_eur_to_index():
    """ Get currencies in EUR """
    url = 'http://data.fixer.io/api/latest?access_key=b5631392d3a91675578eedb12c4954ad'
    result = requests.get(url).json()
    usd = result['rates']

    CurrencyUnit = {
        "CAD": None,
        "HKD": None,
        "IDR": None,
        "KRW": None,
        "TRY": None,
        "PLN": None,
        "JPY": None,
        "BRL": None,
        "AUD": None,
        "INR": None,
        "ZAR": None
    }

    for i in CurrencyUnit:
        CurrencyUnit[i] = float(usd[i])

    return CurrencyUnit


def update_index(index):
    """ Get coins costs in different currencies """
    url = 'https://www.worldcoinindex.com/apiservice/json?key=%s' \
        % WorldIndex_API_KEY

    wci_api = requests.get(url).json()['Markets']
    usd = get_eur_to_index()

    for coin in [x for x in wci_api if x['Name'] in index]:
        CurrencyUnit = {
            "USD": None,
            "CNY": None,
            "EUR": None,
            "GBP": None,
            "RUR": None,
        }

        for unit in CurrencyUnit:
            s = "Price_" + unit.lower()
            CurrencyUnit[unit] = float(coin[s])

        CurrencyUnit["RUB"] = CurrencyUnit.pop("RUR")

        for cur in usd:
            CurrencyUnit[cur] = CurrencyUnit["EUR"] * usd[cur]

        index[coin["Name"]] = CurrencyUnit
    return index


class IndexParser(QObject):
    # declaration of signals
    index_parsed = pyqtSignal(dict)  # dict: {'Bitcoin': {'USD': 1, 'EUR': 2, ...}, ...}

    def __init__(self):
        super().__init__()

    def start_parsing(self, currencies):
        index = {name: None for name in currencies}
        callback = lambda index: self.index_parsed.emit(index)
        async = async_func_with_callback(update_index, callback)
        async(index)
