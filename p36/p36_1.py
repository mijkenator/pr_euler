#!/usr/bin/python

def ispalindrome(n):
    s = str(n)
    if s == s[::-1]:
        b = bin(n)[2::]
        return b == b[::-1]
    else:
        return False

print sum(n for n in xrange(1, 1000000) if ispalindrome(n))

