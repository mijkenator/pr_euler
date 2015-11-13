#!/usr/bin/perl -w

use strict;

sub main{
    my ($a, $b) = (0, 0);
    for (1..shift){ $a+=$_; $b += $_*$_ }
    print "Answer: ".($a*$a - $b)."\n";
}

main(100);
