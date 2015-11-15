#!/usr/bin/perl -w

use strict;


sub main{
    my @fib_array = (1,2);
    my $sum = 0;
    while(1){
        my $new_value = $fib_array[$#fib_array] + $fib_array[$#fib_array-1];
        last if $new_value > 4000000;
        push @fib_array, $new_value;
    }
    for(grep{ !($_%2) } @fib_array){ $sum += $_ }
    print "Answer:  $sum \n"
}

main();
