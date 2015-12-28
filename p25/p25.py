#!/usr/bin/python3
import math

phi = (1 + pow(5, 0.5)) / 2
c = math.log10(5) / 2
logphi = math.log10(phi)
n = 1
while True:
    if n * logphi - c >= 999:
        break
    n = n + 1

print("Answer %s " % n)
