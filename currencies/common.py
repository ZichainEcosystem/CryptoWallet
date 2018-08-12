from currencies.bitcoin_like import BitcoinLikeImpl
from currencies.ethereum_like import EthereumLikeImpl
from currencies.stellar_impl import StellarImpl
from currencies.nem import NemImpl
from currencies.ripple_impl import RippleImpl


cur_dict = {
    'Nem': [NemImpl, 'NEM', 'http://explorer.nemchina.com/#/s_account?account=%s'],
    'Ethereum': [EthereumLikeImpl, 'ETH', 'https://etherscan.io/address/%s'],
    'Stellarlumens': [StellarImpl, 'XLM', 'https://stellarchain.io/address/%s'],
    'Ripple': [RippleImpl, 'XRP', 'https://xrpcharts.ripple.com/#/graph/%s'],
    'Dash': [BitcoinLikeImpl, 'DASH', 'https://chainz.cryptoid.info/dash/address.dws?%s', 0xcc, 0x4c],
    'Bitcoin': [BitcoinLikeImpl, 'BTC',  'https://blockchain.info/ru/address/%s', 0x80, 0x00],
    'Bitcoincash': [BitcoinLikeImpl, 'BCH', 'https://blockchair.com/bitcoin-cash/address/%s', 0x80, 0x00],
    'Bitcoingold': [BitcoinLikeImpl, 'BTG', 'https://btgexplorer.com/address/%s', 0x80, 0x26],
    'Litecoin': [BitcoinLikeImpl, 'LTC', 'https://chainz.cryptoid.info/ltc/address.dws?%s', 0xb0, 0x30],
    'Dogecoin': [BitcoinLikeImpl, 'DOGE', 'https://dogechain.info/address/%s', 0x9e, 0x1e],
    'Komodo': [BitcoinLikeImpl, 'KMD', 'https://kmd.explorer.supernet.org/address/%s', 0xbc, 0x3c],
    'Zcash': [BitcoinLikeImpl, 'ZEC', 'https://explorer.zcha.in/accounts/%s', 0x80, 0x1cb8],
    'Ethereumclassic': [EthereumLikeImpl, 'ETC', 'https://gastracker.io/addr/%s'],
    'Eos': [EthereumLikeImpl, 'EOS', 'https://etherscan.io/token/0x86fa049857e0209aa7d9e616f7eb3b3b78ecfdb0?a=%s'],
    'Tron': [EthereumLikeImpl, 'TRX', 'https://etherscan.io/token/0xf230b790e05390fc8295f4d3f60332c93bed42e2?a=%s'],
    'Vechain': [EthereumLikeImpl, 'VEN', 'https://etherscan.io/token/0xd850942ef8811f2a866692a623011bde52a462c1?a=%s'],
    'Qtum': [EthereumLikeImpl, 'QTUM', 'https://etherscan.io/token/0x9a642d6b3368ddc662CA244bAdf32cDA716005BC?a=%s'],
    'Populous': [EthereumLikeImpl, 'PPT', 'https://etherscan.io/token/0xd4fa1460f537bb9085d22c7bccb5dd450ef28e3a?a=%s'],
    'Icon': [EthereumLikeImpl, 'ICX', 'https://etherscan.io/token/0xb5a5f22694352c15b00323844ad545abb2b11028?a=%s'],
    'Binancecoin': [EthereumLikeImpl, 'BNB', 'https://etherscan.io/token/0xb8c77482e45f1f44de1745f52c74426c631bdd52?a=%s'],
}
