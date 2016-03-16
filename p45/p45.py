#!/usr/bin/python3

import math

def tri_d(n): return n*(n+1)/2
def tri_i(m): return (math.sqrt(1+8*m)-1)/2 

def pen_d(n): return n*(3*n-1)/2
def pen_i(m): return (1+math.sqrt(24*m+1))/6

def hex_d(n): return n*(2*n-1)
def hex_i(m): return (math.sqrt(1+8*m)+1)/4

i = 40756
while True:
        #print("I:%s" %i)
        t,p,h = tri_i(i),pen_i(i),hex_i(i)
        if t.is_integer() and p.is_integer() and h.is_integer():
            print("Answer %s" % i)
            break
        i += 1
