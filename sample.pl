#!/usr/bin/perl

# $Id: sample,v 1.2 2005/05/09 22:47:29 jonathan Exp $

use strict;
use Getopt::Std;

my $usage = "sample -f frequency of sample -r randomly sample (don't just count)\n";

my %para = ();
getopts('f:r', \%para);

my $frequency;
my $rSample = -1;

if (defined($para{'f'})) {
    $frequency = $para{'f'};
} else {
    die ("$usage");
}
if ($frequency <= 0) {
    die ("Invalid frequency $frequency");
}

if (defined($para{'r'})) {
    $rSample = 1.0 / $frequency;
}

my $count = 0;
while (my $line = <>) {
    $count++;
    if ($rSample >= 0) {
	if (rand() < $rSample) {
	    print "$line";
	}
    } elsif ($count == $frequency) {
	print "$line";
	$count = 0;
    }
}
