#!/usr/bin/python

import prime, string
prime._refresh(80000)

def is_8_prime_family(p, d):
    c = 0
    for r in '0123456789':
        np = int(string.replace(p, d, r))
        if(np > 100000 and np < 999999 and prime.isprime(np)): c += 1
    return c==8

n=9000
while(True):
    n += 1
    p = prime.prime(n)
    if p < 100000: continue
    if p > 999999: break
    ps = str(p)
    ld = ps[5:6]
    if (ps.count('0')==3 and is_8_prime_family(ps, '0')) or (ps.count('1')==3 and ld!='1' and is_8_prime_family(ps, '1')) or \
        (ps.count('2')==3 and is_8_prime_family(ps, '2')):
        print "Answer: %s %s" % (n, ps)
        break
