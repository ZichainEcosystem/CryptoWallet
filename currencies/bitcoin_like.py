from bitcoin import bin_to_b58check, encode, sha256, privkey_to_address, signall
import os
import threading

from currencies.currency_interface import ApiCurrency


class KeyGenerator:
    @staticmethod
    def create_pair(b58_magic_byte, address_magic_byte, seed=None):
        """Function create private key and address"""
        if seed is None:
            seed = KeyGenerator.random_seed()
        hash = sha256(seed)
        private_key = int(hash, base=16)
        private_key_wif = bin_to_b58check(encode(private_key, 256, 32), b58_magic_byte)
        address = privkey_to_address(private_key, address_magic_byte)
        return private_key_wif, address

    @staticmethod
    def random_seed():
        """Get 256 random bytes"""
        return os.urandom(256)


class BitcoinLikeImpl(ApiCurrency):
    def __init__(self, seed, name, short_name, url_link, b58_magic_byte, address_magic_byte):
        super().__init__(seed, name, short_name, url_link)
        self.b58_magic_byte = b58_magic_byte
        self.address_magic_byte = address_magic_byte
        self.watch_thread = threading.Thread(target=self.watch, daemon=True)
        self.watch_thread.start()

    def watch(self):
        while True:
            try:
                self.api.watch_address(self.get_short_name(), self.get_address())
                return
            except Exception:
                pass

    def send(self, to_address, amount):
        unsigned_tx = self.api.create_unsigned_tx(self.get_short_name(), self.get_address(), to_address, amount)
        signed_tx = self.sign_tx(unsigned_tx, self.get_private())
        return self.api.push_signed_tx(self.get_short_name(), signed_tx)

    @staticmethod
    def sign_tx(unsigned_tx, private_key):
        """
        :param unsigned_tx: transaction serilization in hex
        :param private_key: private key
        :return: signed transaction
        """
        signed_tx = signall(unsigned_tx, private_key)
        return signed_tx

    def get_address(self):
        priv, addr = KeyGenerator.create_pair(self.b58_magic_byte, self.address_magic_byte, self.seed)
        return addr

    def get_private(self):
        priv, addr = KeyGenerator.create_pair(self.b58_magic_byte, self.address_magic_byte, self.seed)
        return priv
