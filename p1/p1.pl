#!/usr/bin/perl -w

use strict;

sub main(){
    my $answer = 0;
    for(1..999){$answer += $_ if(!($_ % 3) || !($_ % 5))}
    print "Answer: $answer \n"
}

main();
