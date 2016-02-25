#!/usr/bin/python3

from functools import reduce

s = ""
for i in range(1, 1000001): s += str(i)

l = list(s)

print("Answer: %s" % reduce(lambda a,b: a*b, 
    [int(l[x-1]) for x in [1,10,100,1000,10000,100000,1000000]]))
