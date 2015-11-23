#!/usr/bin/perl -w
use strict;

sub primes {
    my @n = (2..110000);
    my @p;
    while (@n && (push @p, shift @n) && $#p < 10000) {
        @n = grep { $_ % $p[-1] } @n;
    }
    return pop @p
}

print "Answer:".primes()."\n";
