#!/usr/bin/perl -w

use strict;

sub primes {
    my @n = (2..shift);
    my @p;
    while (@n && (push @p, shift @n)) {
        @n = grep { $_ % $p[-1] } @n;
    }
    return @p
}


sub is_prime {
    for (2..int(sqrt($_[0]))){ return 0 unless $_[0] % $_}
    1
}

my @p = primes(5000);

my($len, $sum, $mlen, $msum) = (0, 0, 0, 0);
for my $n (0..$#p){
    for my $m ($n..$#p){
        $sum += $p[$m];
        if(is_prime($sum) && $sum < 1000000 && $mlen < $len){
            ($mlen, $msum) = ($len, $sum)
        }elsif($sum < 1000000){ $len++}
        else{ last; }
    }
    ($len, $sum) = (0,0);
}

print $mlen."--".$msum."\n";


