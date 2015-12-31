#!/usr/bin/python3

def recurring_cycle(n, d):
    for t in range(1, d):
        if 1 == pow(10, t, d):
            return (t,d)
    return (0,d)

Answer = sorted([recurring_cycle(1, i) for i in range(2,1001)], key = lambda tup: tup[0])[-1][1]

print("Answer %s" % Answer)
