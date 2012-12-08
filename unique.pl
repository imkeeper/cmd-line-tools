#!/usr/bin/perl

use strict;
use Getopt::Std;

my $usage = "Usage: cat file | unique [-k] [-f]\n";
$usage .=   "           -k column or columns of input to use (first column is 0 and is default)\n";
$usage .=   "           -f outputs the frequency of each term\n";
$usage .=   "           -p outputs the percent frequency of each term\n";

#my $index = 1;
my @index = ();
my %para = ();
getopts('k:fp', \%para);

if (defined($para{'k'})) {
    my $indexes = $para{'k'};

    if ($indexes =~ /^(\d+)-(\d+)$/) {
	my $from = $1;
	my $to = $2;
	for (my $i = $from; $i <= $to; $i++) {
	    #print "idx $i\n";
	    push (@index, $i);
	}
    } elsif ($indexes =~ /^(\d+)$/) {
	push (@index, $indexes);
    } else {
	die ("Invalid index $indexes\n$usage");
    }
} else {
    push (@index, 0);
}

my %data = ();

my $count = 0;
while (my $line = <>) {
    next if ($line =~ /^\#/);
    next if ($line =~ /^\s+$/);
    my @items = split (/\s+/, $line);
    my $key = '';
    foreach my $idx (@index) {
	#print "i $idx item $items[$idx]\n";
	$key .= $items[$idx].' ';
    }
    chop ($key);
    if (!defined ($data{$key})) {
	$data{$key} = 0;
    }
    $data{$key}++;
    $count++;
}

foreach my $key (sort keys %data) {
    my $out = $key;
    if (defined($para{'f'})) {
	$out .= " $data{$key}";
    }
    if (defined($para{'p'})) {
	my $pct = sprintf ("%.4f", $data{$key} / $count);
	$out .= " $pct";
    }
    printf ("$out\n");
}


