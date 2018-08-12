import shamir
import wallet
import utils
import os


class WalletManager:
    __wallet_instance = None

    @staticmethod
    def sign_in(private_list):
        seed = shamir.decrypt(private_list)
        WalletManager.create_wallet(seed.encode())

    @staticmethod
    def sign_up(total_count, needed_count):
        dict_path = os.path.join(utils.root_path(), 'english.txt')
        seed = utils.get_seed(dict_path, 12)
        keys = shamir.crypto_keys(needed_count, total_count, seed)
        WalletManager.create_wallet(seed.encode())
        return keys

    @staticmethod
    def create_wallet(*args, **kwargs):
        WalletManager.exit_wallet()
        WalletManager.__wallet_instance = wallet.Wallet(*args, **kwargs)
        WalletManager.__wallet_instance.start_updating()

    @staticmethod
    def get_wallet():
        if WalletManager.__wallet_instance is None:
            raise Exception('Wallet not created')
        else:
            return WalletManager.__wallet_instance

    @staticmethod
    def exit_wallet():
        try:
            WalletManager.get_wallet().stop_updating()
        except:
            pass
        WalletManager.__wallet_instance = None
