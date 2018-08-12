import hashlib
from ecdsa import SigningKey, SECP256k1
import sha3
import pickle
import rlp

from currencies.currency_interface import ApiCurrency


class EthereumLikeImpl(ApiCurrency):
    def __init__(self, seed, name, short_name, url_link):
        super().__init__(seed, name, short_name, url_link)

    def prepare_seed(self):
        str = hashlib.sha256(self.seed).hexdigest()
        bytes = bytearray.fromhex(str)
        return bytes

    @staticmethod
    def create_account(seed=None):
        if seed is None:
            key = SigningKey.generate(curve=SECP256k1)
        else:
            key = SigningKey.generate(curve=SECP256k1, entropy=lambda x: seed)
        priv = '0x' + key.to_string().hex()
        return priv, EthereumLikeImpl._privtoaddr(priv)

    @staticmethod
    def _privtoaddr(privkey):
        keccak = sha3.keccak_256()
        priv = SigningKey.from_string(
            bytes.fromhex(privkey[2:]),
            curve=SECP256k1,
        )
        pub = priv.get_verifying_key().to_string()
        keccak.update(pub)
        return '0x' + keccak.hexdigest()[24:]

    def get_address(self):
        priv, addr = EthereumLikeImpl.create_account(self.prepare_seed())
        return addr

    def get_private(self):
        priv, addr = EthereumLikeImpl.create_account(self.prepare_seed())
        return priv

    @staticmethod
    def sign_tx(unsigned_tx, private_key):
        tx_obj = pickle.loads(bytes.fromhex(unsigned_tx))
        tx_hex = rlp.encode(tx_obj.sign(private_key)).hex()
        return tx_hex

    def send(self, to_address, amount):
        unsigned_tx = self.api.create_unsigned_tx(self.get_short_name(), self.get_address(), to_address, amount)
        signed_tx = EthereumLikeImpl.sign_tx(unsigned_tx, self.get_private())
        return self.api.push_signed_tx(self.get_short_name(), '0x' + signed_tx)