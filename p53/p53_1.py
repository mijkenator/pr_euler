import math, functools
count = 0

@functools.lru_cache(maxsize = 1000)
def f(n,r):
     return math.factorial(n) / (math.factorial(r) * math.factorial(n-r)) 

for n in range(1,101):
    for r in range(1,n+1):
        if f(n,r) >= 1000000: count += 1

print("Answer %s" % count)

