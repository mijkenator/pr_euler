#!/usr/bin/python3

import prime

MAX = 10000
prime._refresh(MAX)
squares = dict.fromkeys((x*x for x in range(1, MAX)), 1)

for x in range(35, MAX, 2):
    if not prime.isprime(x):
        is_goldbach = 0
        for p in prime.prime_list:
            if p >= x: break
            key = (x-p)/2
            if key in squares:
                is_goldbach = 1
                break
        if not is_goldbach:
            print(x)
            break

