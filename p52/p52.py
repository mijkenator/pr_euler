#!/usr/bin/python3

def answer(i):
    istr = ''.join(sorted(str(i)))
    for j in range(2,7):
        if ''.join(sorted(str(i*j))) != istr: return False
    return True

n, s = 1, True;
while(s):
    n *= 10
    for i in range(n, int(n*10/6)+1):
        if answer(i):
            print("Answer %s" % i)
            s = False
            break


