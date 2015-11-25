#!/usr/bin/python

for a in xrange(1, 1000):
    for b in xrange(a, 1000):
        c = 1000 - a - b
        if c > 0:
            if c*c == a*a + b*b:
                answer = a*b*c
                print "Answer %d " % answer
                break
