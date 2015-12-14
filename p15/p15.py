#!/usr/bin/python

def fact(n):
    f = 1
    for x in xrange(1, n+1): f = f * x
    return f

print("Answer: %d" % (fact(40) / fact(20) / fact(20)))
