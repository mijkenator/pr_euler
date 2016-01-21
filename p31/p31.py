#!/usr/bin/python

def test31(t, c):
    ways = [1] + [0]*t
    for coin in c:
        for i in range(coin, t+1):
            ways[i] += ways[i-coin]
    return ways[t]

coins = (1, 2, 5, 10, 20, 50, 100, 200)

print test31(200, coins)
