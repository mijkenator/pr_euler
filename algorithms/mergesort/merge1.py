#!/usr/bin/python3

import random
from heapq import merge

def m(l):
    if len(l) <= 1: return l
    middle = len(l) // 2
    left, right = l[:middle], l[middle:]
    left  = m(left)
    right = m(right) 

    return list(merge(left, right))

l = [random.randint(1,10000) for _ in range(1,5000000)]
#print(l)
#print(m(l))

m(l)
print("Done")
