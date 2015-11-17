#!/usr/bin/python

n = 0
for a in xrange(999, 100, -1):
     for b in xrange(a, 100, -1):
         x = a * b
         if x > n:
             s = str(x)
             if s == s[::-1]: n = x
print n
