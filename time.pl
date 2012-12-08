#!/usr/bin/perl

use strict;
use Getopt::Std;

my %para = ();
getopts('c:', \%para);
if (!defined($para{'c'})) {
    $para{'c'} = 0;
}

while (my $line = <STDIN>) {
    next if ($line =~ /^\#/);
    my (@item) = split (/\s/,$line);
    my $i = $item[$para{'c'}];
    next if (!defined($i));

    #13162 07199 534
    if ($i =~ /(\d\d\d\d\d\d\d\d\d\d)\d\d\d/) {
	$i = $1;
    }

    my $stamp = &epoch ($i);
    $item[$para{'c'}] = $stamp;
    print "@item\n";
}



sub epoch {
    my ($epoch) = @_;

  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
    localtime($epoch);
  $year += 1900;
  $mon++;

    #my $stamp = sprintf ("$year-%02d-%02d %02d:%02d (wday=$wday,yday=$yday,year=$year)", $mon,
    #$mday,$hour,$min);

  my $stamp = sprintf ("$year-%02d-%02d %02d:%02d:%02d", $mon,
		       $mday,$hour,$min,$sec);


    #print "$stamp\n";
    return $stamp;
}
