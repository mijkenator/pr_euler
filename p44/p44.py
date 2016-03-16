#!/usr/bin/python3

import math

def fun_i(m): return (1 + math.sqrt(24*m+1)) / 6

def fun_d(n): return n*(3*n - 1) / 2


i, not_found = 1, True
while not_found:
    i += 1
    n = fun_d(i)
    for j in range(i-1,0,-1):
        n1 = fun_d(j)
        a, b = n-n1, n+n1
        p1, p2 = fun_i(a), fun_i(b)
        if p1.is_integer() == True and p2.is_integer() == True:
            print("n:%s n1:%s a:%s b:%s p1:%s p2:%s D:%s" % (n,n1,a,b,p1,p2, n-n1))
            not_found = False
            break

print("Answer: %s" % int(n-n1))






