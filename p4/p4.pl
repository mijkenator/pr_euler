#!/usr/bin/perl -w
use strict;

my $answer = 0;
for my $x (-999..-100){
    for my $y ($x..-100){
        my $n = $x*$y;
        $answer = $n if $n > $answer && $n == reverse(split(//,$n))   
    }    
}
print "Answer: $answer \n";
