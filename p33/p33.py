#!/usr/bin/python3

def isPhr(x, y):
    if x == y: return False
    if x % 10 == 0 and y % 10 == 0: return False

    inter = [i for i in str(y) if i in str(x)]
    if  inter != []:
       x1 = "".join([i for i in str(x) if i not in inter])
       y1 = "".join([i for i in str(y) if i not in inter])
       if x1 == "" or y1 == "": return False
       if x1 == "0" or y1 == "0": return False
       if x / y == int(x1) / int(y1):
           return True
       else:
           return False
    else:
       return False

am, bm = 1,1
for (a,b) in [(x,y) for x in range(10,100) for y in range(10,100) if x < y and isPhr(x,y)]:
        am *= a
        bm *= b 

print("Answer %s" % (bm // am))

