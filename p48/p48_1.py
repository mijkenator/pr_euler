#!/usr/bin/python3

from functools import reduce

answer = reduce(lambda x,y: x+pow(y,y), range(1,1001)) % pow(10,10)

print(answer)
