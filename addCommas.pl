#!/usr/bin/perl

use strict;

my $in = '';
while (my $line = <>) {
    chop($line);
    $in = $in."$line,";
}
print "$in";
