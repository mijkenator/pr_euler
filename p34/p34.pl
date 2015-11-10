#!/usr/bin/perl -w
use strict;

my %f = ();

sub main(){
    my $limit = 7*fact(9);
    my $sum = 0;
    %f = map{ $_ => fact($_)} 0..9;
    for(my $i=10;$i<$limit;$i++){
        $sum += $i if $i == sumofd($i)    
    }
    print "Answer: $sum \n";
}

sub fact{
    my $num = shift;
    if($num == 0){ 1 }
    else{ 
        my ($f,$i) = (1, 1);
        $f *= ++$i while $i < $num;
        $f
    }
}

sub sumofd{
    my $s = 0;
    map { $s += $f{$_} } split(//, shift);
    $s
}

main();
