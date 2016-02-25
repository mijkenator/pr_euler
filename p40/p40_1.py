#!/usr/bin/python3
from functools import reduce

def dn(n, l):
    if n == 1: return 1
    (ln, start, end) = next((i+1,l[i-1],v) for i,v in enumerate(l) if v > n)
    d = (n - start) // ln + 10**(ln-1)
    return list(str(d))[(n-start) % ln -1]

l, m, previous = [1,10,100,1000,10000,100000,1000000], [], 0

for x in l:
    a = len(str(x))
    previous += 9*(10**(a-1))*a
    m.append(previous)


print("Answer: %s" % reduce(lambda a,b: a*b, [int(dn(x,m)) for x in l]))

