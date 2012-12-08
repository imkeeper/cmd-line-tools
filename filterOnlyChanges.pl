#!/usr/bin/perl

use strict;
use Getopt::Std;
use POSIX qw(ceil floor);

my $usage = "Usage: cat file | filterOnlyChanges.pl -c [column] > output \n".
    " Only output a line if value in column c is different from previous value\n";

my %para = ();
getopts('c:', \%para);

my $previousValue = '';

while (my $line = <STDIN>) {
    next if ($line =~ /^\#/);

    my (@item) = split (/\s/,$line);
    my $i = $item[$para{'c'}];
    next if (!defined($i));

    if ($previousValue eq '' || $previousValue != $i) {
	print "$line";
	$previousValue = $i;
    }

}
