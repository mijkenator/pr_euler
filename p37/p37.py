#!/usr/bin/python

import math, prime

def is_left_truncatable(i):
    while True:
        if prime.isprime(i):
            if i > 10: i = int(''.join(list(str(i))[1::]))
            else: return True
        else: return False

def is_right_truncatable(i):
    while True:
        if prime.isprime(i):
            if i > 10: 
                a = list(str(i))
                a.pop()
                i = int(''.join(a))
            else: return True
        else: return False

def p37():
    start,answer,count = 1,0,0
    while True:
        for i,v in enumerate(prime.prime_list[start+1::], start=start+1):
            if v > 7 and is_left_truncatable(v) and is_right_truncatable(v):
                answer += v
                count += 1
                if count == 11: return answer
        start = i
        prime._refresh(v*2)

print "Answer %s" % p37()


