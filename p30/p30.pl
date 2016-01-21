#!/usr/bin/perl -l

use strict;
use warnings;
use List::Util qw/sum/;

print sum grep { $_ == sum map $_**5, /./g } 2..6*9**5;
