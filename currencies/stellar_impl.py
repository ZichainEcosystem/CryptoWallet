from stellar_base.keypair import Keypair
from stellar_base.builder import Builder
from hashlib import sha256

from currencies.currency_interface import ApiCurrency


class StellarImpl(ApiCurrency):
    def __init__(self, seed, name, short_name, url_link):
        super().__init__(seed, name, short_name, url_link)

    def get_kp(self):
        return Keypair.from_raw_seed(sha256(self.seed).digest())

    def get_private(self):
        return self.get_kp().seed().decode()

    def get_address(self):
        return self.get_kp().address().decode()

    def send(self, to_address, amount):
        signed_tx = StellarImpl.create_signed_tx(self.get_private(), to_address, amount)
        return self.api.push_signed_tx(self.get_short_name(), signed_tx)

    @staticmethod
    def create_signed_tx(private_key, to_address, amount, network='PUBLIC', memo=None):
        amount = round(amount, 7)
        builder = Builder(secret=private_key, network=network)
        builder.append_payment_op(to_address, amount, 'XLM')
        if memo:
            builder.add_text_memo(memo)
        builder.sign()
        return builder.gen_xdr().decode()