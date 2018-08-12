import sys
import os
import threading
import binascii


def root_path():
    """
    Return root path for application
    :return: path
    """
    try:
        root_path = sys._MEIPASS
    except:
        root_path = os.path.dirname(os.path.abspath(__file__))
    return root_path


def bin_path():
    """
    Return bin path for application
    :return: path
    """
    bin = os.path.join(root_path(), 'bin')
    if not os.path.exists(bin):
        os.makedirs(bin)
    return bin


def qml_path():
    """
    Return qml path for application
    :return: path
    """
    bin = os.path.join(root_path(), 'qmls')
    if not os.path.exists(bin):
        os.makedirs(bin)
    return bin


def get_seed(dictionary_path, count):
    """
    Return specified number of words from given file path
    :param dictionary_path: path to dictionary
    :param count: number of random words
    :return: list
    """
    word_list = get_word_list_from_file(dictionary_path)
    word_number = len(word_list)
    seed = list()
    for i in range(count):
        index = int(binascii.hexlify(os.urandom(word_number)), 16) % word_number
        seed.append(word_list[index])
    return ' '.join(seed)


def get_word_list_from_file(dictionary_path):
    """
    Read words from given file
    :param dictionary_path: path to file
    :return: list
    """
    file = open(dictionary_path, 'r')
    word_list = []
    with file as openfileobject:
        for line in openfileobject:
            word_list.append(line[0:-1])
    file.close()
    return word_list


def loger(fn):
    """
    Decorator for debugging
    :param fn:
    :return:
    """
    def wrapper(*args, **kwargs):
        print('Function %s called with argument:' % fn.__name__)
        print(args, kwargs)
        return fn(*args, **kwargs)

    return wrapper


def async_func_with_callback(func, callback):
    """
    Return a function that will start func in another thread. After the work is done, callback will be called
    :param func: function(*args, **kwargs) -> res
    :param callback: function(res)
    :return: function(*args, **kwargs)
    """
    def wrapped(*args, **kwargs):
        result = func(*args, **kwargs)
        callback(result)

    def async_fun(*args, **kwargs):
        thr = threading.Thread(target=wrapped, args=args, kwargs=kwargs)
        thr.start()

    return async_fun

