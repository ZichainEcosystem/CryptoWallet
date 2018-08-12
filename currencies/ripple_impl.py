from ripple.sign import get_ripple_from_secret, RippleBaseDecoder
from ripple import sign_transaction
from ripple.client import transaction_hash
from ripple.serialize import serialize_object
from hashlib import sha512, sha256
import os

from currencies.currency_interface import ApiCurrency


class RippleSeedEncoder(RippleBaseDecoder):
    @classmethod
    def encode(cls, data):
        """Apply base58 encode including version, checksum."""
        version = b'\x21'
        bytes = version + data
        bytes += sha256(sha256(bytes).digest()).digest()[:4]  # checksum
        return cls.encode_base(bytes)


class KeyGenerator:
    @staticmethod
    def create_pair(seed=None):
        if seed is None:
            seed = KeyGenerator.random_seed()
        secret = sha512(seed).digest()[:16]
        secret_b58 = RippleSeedEncoder.encode(secret)
        address = get_ripple_from_secret(secret_b58)
        return secret_b58, address

    @staticmethod
    def random_seed():
        """Get 256 random bytes"""
        return os.urandom(256)


class RippleImpl(ApiCurrency):
    def __init__(self, seed, name, short_name, url_link):
        super().__init__(seed, name, short_name, url_link)

    def get_private(self):
        priv, addr = KeyGenerator.create_pair(self.seed)
        return priv

    def get_address(self):
        priv, addr = KeyGenerator.create_pair(self.seed)
        return addr

    @staticmethod
    def sign_tx(unsigned_tx, private_key):
        signed_tx = sign_transaction(unsigned_tx, private_key)
        return {'id': transaction_hash(signed_tx).decode(), 'tx': serialize_object(signed_tx)}

    def send(self, to_address, amount):
        unsigned_tx = self.api.create_unsigned_tx(self.get_short_name(), self.get_address(), to_address, amount)
        signed_tx = RippleImpl.sign_tx(unsigned_tx, self.get_private())
        return self.api.push_signed_tx(self.get_short_name(), signed_tx)
