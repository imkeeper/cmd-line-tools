#!/usr/bin/perl

use strict;
use Getopt::Std;

my $usage = "Usage: cat **sorted-file** | cdf [options] > result\n";
$usage .=   "           -c print complementary CDF\n";
$usage .=   " Assumes input is sorted how you want it";

my %para = ();
getopts('c', \%para);

my @data = ();
while (my $line = <>) {
    $data[$#data+1] = $line;
}

for (my $i = 0; $i <= $#data; $i++) {
    my $index = ($i/$#data);
    if (defined($para{'c'})) {
	$index = 1.-$index;
    }
    #printf ("%1.14f $data[$i]", $index);
    my $data = $data[$i];
    chomp($data);
    my $out = printf ("$data %1.14f", $index);
    print "$out\n";
}

