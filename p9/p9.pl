#!/usr/bin/perl -w
use strict;

for my $a (1..1000){
    for my $b ($a..1000){
        my $c = 1000 - $a - $b;
        if($c > 0 && ($a*$a+$b*$b == $c*$c)){
            print "Answer: ".$a*$b*$c."\n";
            last;
        }
    }    
}
