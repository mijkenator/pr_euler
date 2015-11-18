#!/usr/bin/python

# Euclid's algorithm
def gcd(a, b): return b and gcd(b, a % b) or a 
def lcm(a, b): return a * b / gcd(a, b)

answer = 1
for i in xrange(1,21): answer = lcm(answer,i)

print "Answer %d " % answer
