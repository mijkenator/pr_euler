#!/usr/bin/python
import math

def main():
    l = limit()
    print "limit: %d" % l
    s = 0
    f = {}
    for x in range(0, 10): f[str(x)] = math.factorial(x)
    for x in range(10, l):
        if x == sum(map(lambda y: f[y], str(x))): s += x
    print "Answer: %d" % s

def limit():
    return math.factorial(9)*7

main()
