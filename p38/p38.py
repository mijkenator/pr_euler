#!/usr/bin/python

def t38():
    for n in range(9876,9213,-1):
        d = str(n) + str(n*2)
        if is_pandigital(d): return d
    return 0

def is_pandigital(n):
    if len(n) != 9:
        return False
    if "".join(sorted(set(n))) == "123456789":
        return True
    else:
        return False
    

print "Answer: %s" % t38() 
