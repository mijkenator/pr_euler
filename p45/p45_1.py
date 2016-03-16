#!/usr/bin/python3

import math

def pen_i(m): return (1+math.sqrt(24*m+1))/6
def hex_d(n): return n*(2*n-1)

i = 144
while True:
    p = pen_i(hex_d(i))
    if p.is_integer():
        print("Answer: %s" % hex_d(i))
        break
    i += 1
