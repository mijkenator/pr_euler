#!/usr/bin/python3

import math

words = open("/home/mkh/work/mblog/pr_euler/p42/p042_words.txt").read().replace('"', '').split(',')

def is_triangle(w):
    t = sum(ord(letter) - ord('A') + 1 for letter in w)
    n = (math.sqrt(1+8*t)-1) / 2
    return n.is_integer()

print(sum([1 for w in words if is_triangle(w)]))

