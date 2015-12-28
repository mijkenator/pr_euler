#!/usr/bin/python3
import itertools

c = 0
for values in itertools.permutations([0,1,2,3,4,5,6,7,8,9]):
    c += 1
    if c == 1000000:
        print (values)
        break
