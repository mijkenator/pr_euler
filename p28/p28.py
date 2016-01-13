#!/usr/bin/python

def t28(n):
    while n > 0:
        yield 4*(2*n+1)**2 - 12*n
        n -= 1
    yield 1

print "Answer: %s" % sum(t28(500))
