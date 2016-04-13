#!/usr/bin/python

import prime

num, count, answer    = 644, 0, 0

while True:
    if len(set(list(prime.factors(num)))) == 4:
        if count == 0: answer = num
        count += 1
        if count == 4:
            print "Answer: %s" % answer
            break
    else: answer, count = 0, 0
    num += 1
