from nem_ed25519 import secret_key, public_key, get_address, sign
import hashlib
import datetime
import numpy as np
import math

from currencies.currency_interface import ApiCurrency

MAIN_NET = (0x68000000 | 1)


class NemImpl(ApiCurrency):
    def __init__(self, seed, name, short_name, url_link):
        super().__init__(seed, name, short_name, url_link)

    @staticmethod
    def create_account(seed=None):
        if seed is None:
            sk = secret_key()
        else:
            str = hashlib.sha512(seed).hexdigest()
            sk = secret_key(str.encode())
        pk = public_key(sk)
        ck = get_address(pk, main_net=True)
        return sk, ck

    def get_address(self):
        priv, addr = NemImpl.create_account(self.seed)
        return addr

    def get_private(self):
        priv, addr = NemImpl.create_account(self.seed)
        return priv

    @staticmethod
    def create_unsigned_tx(from_public_key, to_address, amount):
        tx_object = {
            "timeStamp": NemImpl._get_timestamp(),
            "amount": round(amount * 10 ** 6),
            "fee": NemImpl._estimate_fee(amount),
            "recipient": to_address,
            "type": 0x101,
            "deadline": NemImpl._get_timestamp() + 60 * 60,
            "message":
                {
                    "payload": '',
                    "type": 1
                },
            "version": MAIN_NET,
            "signer": from_public_key
        }
        serialized_tx = NemImpl._serialize_tx_object(tx_object)
        binary_data = bytearray()
        for item in serialized_tx:
            binary_data.append(item)
        binary_data = bytes(binary_data)
        return binary_data

    @staticmethod
    def _get_timestamp():
        now = datetime.datetime.utcnow()
        nemEpoch = datetime.datetime(2015, 3, 29, 0, 6, 25, 0, None)
        return int((now - nemEpoch).total_seconds())

    @staticmethod
    def _estimate_fee(amount):
        return min(round(amount / 10000 + 0.5) * 50000, 1250000)

    @staticmethod
    def _serialize_tx_object(entity):
        """
        Python implementation of
        https://github.com/QuantumMechanics/NEM-sdk/blob/f495104f6dd4f8fb4baaf4ae5fbaf6dd36249177/src/utils/serialization.js#L255
        :param entity:
        :return:
        """
        r = bytearray(512 + 2764)
        d = np.frombuffer(r, dtype="uint32", count=-1)
        b = np.frombuffer(r, dtype="uint8", count=-1)
        d[0] = entity['type']
        d[1] = entity['version']
        d[2] = entity['timeStamp']

        temp = bytearray.fromhex(entity["signer"])
        d[3] = len(temp)
        e = 16
        for j in range(0, len(temp)):
            b[e] = temp[j]
            e += 1

        i = int(e / 4)
        d[i] = entity['fee']
        i += 1
        d[i] = int(entity['fee'] / 0x100000000)
        i += 1
        d[i] = entity['deadline']
        i += 1
        e += 12

        if d[0] == 257:
            d[i] = len(entity['recipient'])
            i += 1
            e += 4

            for j in range(0, len(entity['recipient'])):
                b[e] = ord(entity['recipient'][j])
                e += 1

            i = int(e / 4)
            d[i] = entity['amount']
            i += 1
            d[i] = math.floor(entity['amount'] / 0x100000000)
            i += 1
            e += 8

            if entity['message']['type'] == 1 or entity['message']['type'] == 2:
                temp = bytearray.fromhex(entity['message']['payload'])
                if len(temp) == 0:
                    d[i] = 0
                    i += 1
                    e += 4
                else:
                    d[i] = 8 + len(temp)
                    i += 1
                    d[i] = entity['message']['type']
                    i += 1
                    d[i] = len(temp)
                    i += 1
                    e += 12
                    for j in range(0, len(temp)):
                        b[e] = temp[j]
                        e += 1
        return np.frombuffer(r, dtype="uint8", count=e)

    @staticmethod
    def sign_tx(unsigned_tx, private_key):
        pub_key = public_key(private_key)
        signature = sign(unsigned_tx, private_key, pub_key)
        return {
            'data': unsigned_tx.hex(),
            'signature': signature.hex()
        }

    def send(self, to_address, amount):
        pub_key = public_key(self.get_private())
        unsigned_tx = NemImpl.create_unsigned_tx(pub_key, to_address, amount)
        signed_tx = NemImpl.sign_tx(unsigned_tx, self.get_private())
        return self.api.push_signed_tx(self.get_short_name(), signed_tx)
