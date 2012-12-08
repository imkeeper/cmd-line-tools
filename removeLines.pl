#!/usr/bin/perl

use strict;
use Getopt::Std;

my $usage = "Usage: removeLines.pl -r [bad lines] [input file]\n";
$usage .=   "       bad lines contains lines that should be removed from the input file\n";

my %para = ();
getopts('r:', \%para);

if (!defined($para{'r'})) {
    die ($usage);
}
my $badFile = $para{'r'};

my %badLines = ();
open BAD, $badFile or die ("Cannot open $badFile");
while (my $line = <BAD>) {
    chomp $line;
    $badLines{$line} = 1;
}
close BAD;

while (my $line = <>) {
    chomp $line;
    next if (defined($badLines{$line}));
    print "$line\n";
}
