#!/usr/bin/python

import prime

MAX = 5000
prime.prime(MAX)

def check_length(n, below):
    maxprime = 0
    for x in xrange(0, below):
        total = sum(prime.prime_list[x:x+n])
        if total > below: break
        if prime.isprime(total): maxprime = total
    return maxprime

for n in xrange(1000, 0, -1):
    maxprime = check_length(n, 1000000)
    if maxprime:
        print maxprime
        break
