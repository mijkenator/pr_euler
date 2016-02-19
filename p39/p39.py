#!/usr/bin/python3

import operator

def get_abc(a, p):
    b = (p**2 - 2*p*a) / (2*p - 2*a)
    c = (a**2 + b**2)**0.5
    return (a, b, c)

d = dict()
for p in range(12,1001):
    d[p] = 0
    for a in range(1,p//3):
        (a, b, c) = get_abc(a, p)
        if c.is_integer(): 
            d[p] += 1

print("P: %s number:%s" % sorted(d.items(), key=operator.itemgetter(1))[-1])
            
