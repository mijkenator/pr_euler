#!/usr/bin/perl -w
use strict;

sub test31{
    my ($target, $coins) = @_;
    
    my @ways = (1) + (0) x $target;
    foreach my $coin ( @$coins ) {
        foreach my $i ( $coin .. $target ){
            $ways[$i] += $ways[$i-$coin]
        }
    }
    $ways[$target]
}

print test31(200, [1, 2, 5, 10, 20, 50, 100, 200])."\n";
