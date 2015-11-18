#!/usr/bin/perl
use strict;

sub gcd{
    my ($a, $b, @r) = @_;
    @r ? gcd($a, gcd($b,@r)) : $b == 0 ? $a : gcd($b, $a % $b)
}

sub lcm{
    my ($a, $b, @r) = @_;    
    @r ? lcm($a, lcm($b, @r)): $a * $b / gcd($a, $b)
}

print "Answer".lcm(1 .. 20)."\n";
