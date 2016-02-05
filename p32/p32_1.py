#!/usr/bin/python

def isPandigital(x,y):
    p = x*y
    s = str(x)+str(y)+str(p)
    if len(s) != 9:
        return False
    if "".join(sorted(set(s))) == "123456789":
        return True
    else:
        return False

pd = [x*y for x in xrange(1,100) for y in xrange(100,10000) if isPandigital(x,y)]

print "Answer: %s" % sum(set(pd))


