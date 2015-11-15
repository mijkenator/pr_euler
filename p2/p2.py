#!/usr/bin/python

def main():
    answer = 2
    fib_a  = 2
    fib_b  = 1

    while fib_a < 4000000:
        fib_a, fib_b = fib_a + fib_b, fib_a
        if fib_a % 2 == 0: answer += fib_a 

    print "Answer %d " % answer

main()
