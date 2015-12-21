#!/usr/bin/python

def worth(name): return sum(ord(letter) - ord('A') + 1 for letter in name)

txt = open("p022_names.txt")
fl  = txt.read()[1:][:-1].split('","')
fl.sort()
 
answer = sum((i+1) * worth(fl[i]) for i in xrange(0, len(fl)))

print "Answer %s " % answer
