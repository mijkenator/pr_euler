#!/usr/bin/perl

use strict;

my ($i, $n) = (2, 600851475143);
while($i*$i < $n){
    $n /= $i while !($n % $i);
    $i++
}

print "Answer: $n \n";
