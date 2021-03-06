#!/usr/bin/python

def prime_sieve(n):
    sieve = [True] * (n/2)
    for i in xrange(3,int(n**0.5)+1,2):
        if sieve[i/2]:
            sieve[i*i/2::i] = [False] * ((n-i*i-1)/(2*i)+1)
    return [2] + [2*i+1 for i in xrange(1,n/2) if sieve[i]]

for d in prime_sieve(1000)[::-1]:
    period = 1
    while pow(10, period, d) != 1:
        period += 1
    if d-1 == period: break
 
print("longest recurring cycle for 1/d, d =", d)
