#!/usr/bin/python3
import random
from timeit import default_timer as timer

def qs(l):
    if len(l) == 0: return []
    return qs([x for x in l[1:] if x < l[0]]) + [l[0]] + qs([x for x in l[1:] if x >= l[0]])


l = [random.randint(1,10000) for _ in range(1,5000000)]

start=timer()
l1 = qs(l)
end=timer()

print("Done: %s" % str(end - start))
