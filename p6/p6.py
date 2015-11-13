#!/usr/bin/python

def main():
    r = range(1,101)
    a = sum(r)
    answer = a*a - sum(x*x for x in r)
    print "Answer: %d" % answer

main()
