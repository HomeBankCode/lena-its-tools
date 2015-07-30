# compatible API between python2 and python3

from __future__ import print_function
import sys


def pythonVersion():
    return sys.version[0]


def myDebug(*args, **kwargs):
    print(args, kwargs)
