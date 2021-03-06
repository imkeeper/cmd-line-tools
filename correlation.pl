#!/usr/bin/perl

use strict;
use Getopt::Std;
use Statistics::Basic::Correlation;

#my $co = new Statistics::Basic::Correlation( [1..3], [1..3] );
#print $co->query, "\n";

# Jonathan Ledlie
# June 16 2004

##################################################

my $usage = "Usage: cat file | correlation [options] > result\n";
$usage .=   "           -a first column of input to use\n";
$usage .=   "           -b second column of input to use\n";
$usage .=   "           First column is 1 (not 0)\n";

my $colA = -1;
my $colB = -1;
my %para = ();
getopts('a:b:', \%para);

if ( !defined($para{'a'}) || !defined($para{'b'})) {
    die ($usage);
}
$colA = $para{'a'};
$colB = $para{'b'};

my @A = ();
my @B = ();

while (my $line = <>) {
    my @items = split (/\s+/, $line);
    if (defined ($items[$colA-1]) && defined ($items[$colB-1])) {
	my $itemA = $items[$colA-1];
	my $itemB = $items[$colB-1];
	if ($itemA =~ /-?\d+\.?\d*/) {
	    push (@A, $itemA);
	} else {
	    die ("NaN A $itemA line $line");
	}

	if ($itemB =~ /-?\d+\.?\d*/) {
	    push (@B, $itemB);
	} else {
	    die ("NaN B $itemB line $line");
	}
	#warn "a $itemA b $itemB\n";
    }
}

my $co = new Statistics::Basic::Correlation( \@A, \@B );
print $co->query, "\n";
