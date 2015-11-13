#!/usr/bin/python
import math

def main():
    answer = sum(x for x in range(1, 1000) if not(x % 3) or not(x % 5)) 
    print "Answer: %d" % answer


main()
