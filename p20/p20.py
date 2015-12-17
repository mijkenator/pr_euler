#!/usr/bin/python

import math

def digits(n):
    s = 0
    while n > 0:
        s = s + (n % 10)
        n = n / 10
    return s

print "Answer %s" % digits(math.factorial(100))

print "Answer (onliner) %s " % sum(map(int, str(math.factorial(100))))
