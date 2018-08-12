import requests
import json


def post(url, args):
    headers = {'content-type': 'application/json'}
    response = requests.post(
        url,
        data=json.dumps(args),
        headers=headers,
        timeout=5
    )
    try:
        result = response.json()
    except Exception:
        raise Exception(str(response) + response.text)
    if 'error' in result:
        raise Exception(result['error'])
    return result['data']


def get(url):
    response = requests.get(
        url,
        timeout=5
    )
    try:
        result = response.json()
    except Exception:
        raise Exception(str(response) + response.text)
    if 'error' in result:
        raise Exception(result['error'])
    return result['data']


class Api:
    def __init__(self, host):
        self.host = host

    def _path(self, *args):
        url = self.host
        for arg in args:
            url += '/' + arg
        return url

    def get_balance(self, currency, address):
        result = get(self._path('getbalance', currency, address))
        return float(result['balance'])

    def get_history(self, currency, address):
        result = get(self._path('gethistory', currency, address))
        return result

    def push_signed_tx(self, currency, tx):
        result = post(self._path('pushsignedtx', currency), {
            'signed_tx': tx
        })
        return result

    def create_unsigned_tx(self, currency, src_address, dst_address, amount):
        result = post(self._path('createunsignedtx', currency), {
            'from': src_address,
            'to': dst_address,
            'amount': float(amount)
        })
        return result

    def watch_address(self, currency, address):
        get(self._path('watchaddress', currency, address))
