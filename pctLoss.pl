#!/usr/bin/perl

use strict;
use Getopt::Std;
use POSIX qw(ceil floor);

my $usage = "Usage: cat file | pctLoss.pl -c [column] -p [value] -a > output \n".
    " Take column c as 100%, then output the pct loss/gain vs the value\n".
    " -a Use the first column for the value\n";

my %para = ();
getopts('c:ap:', \%para);

while (my $line = <STDIN>) {
    next if ($line =~ /^\#/);

    my (@item) = split (/\s/,$line);
    my $i = $item[$para{'c'}];
    my $ip = $i;
    next if (!defined($i));

    if (!defined($para{'p'}) && defined($para{'a'})) {
	$para{'p'} = $i;
    }

    #print "i $i p ".$para{'p'}." $line\n";

    if (defined($para{'p'})) {
	$i = $i/$para{'p'};
    }

    #print "was $ip now $i\n";

    $item[$para{'c'}] = $i;

    print "@item\n";

}
