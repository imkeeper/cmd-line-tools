#!/usr/bin/perl

use strict;
use Getopt::Std;
use POSIX qw(ceil floor);

# Usage
# Outputs normal density function given a mean and sd
# -s standard deviation
# -m mean
# -n normalization factor (multiply result by this amount), optional

my %para = ();
getopts('s:m:n:', \%para);
if (!exists ($para{'s'}) || !exists ($para{'m'})) {
    die ("mean and standard deviation required");
}

my $norm = 1.0;
if (exists ($para{'n'})) {
    $norm = $para{'n'};
}

my $sd = $para{'s'};
my $mean = $para{'m'};

my $start = floor($mean - ($sd * 5));
my $end = ceil($mean + ($sd * 5));

my $pi = 3.141593;

my $var = $sd**2;

for (my $x = $start; $x < $end; $x+=0.1) {
    my $e = exp( -1 * (($x-$mean)**2) / (2*$var));
    my $d = sqrt($var) * sqrt(2*$pi);
    my $y = 1.0/$d*$e * $norm;
    printf ("%5.5f %5.5f\n", $x, $y);
}
