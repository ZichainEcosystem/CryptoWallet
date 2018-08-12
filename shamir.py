import tss
import base58

__all__ = ['crypto_keys', 'decrypt']


def crypto_keys(k, n, seed):
    shares = tss.share_secret(k, n, seed, "no", tss.Hash.SHA256)
    keys = []
    for i in shares:
        keys.append(serialize_shamir(i))
    return keys


def decrypt(keys):
    for i in range(len(keys)):
        keys[i] = deserialize_shamir(keys[i])
    secret = tss.reconstruct_secret(keys)
    return secret.decode()


def serialize_shamir(a):
    return base58.b58encode(a).decode()


def deserialize_shamir(a):
    return base58.b58decode(a)



