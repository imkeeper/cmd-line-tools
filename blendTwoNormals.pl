#!/usr/bin/perl

use strict;
use Math::Random;
use Getopt::Std;

my $usage = "Usage: blendTwoNormals.pl -n [count]\n";
$usage .=   "       -f [frac taken from distribution 1]\n";
$usage .=   "       -m [mean1] -s [stddev1]\n";
$usage .=   "       -M [mean2] -S [stddev2]\n";
$usage .=   "       -r [round each number to nearest integer\n";

my $user_count = 0;
my %para = ();
getopts('f:n:m:s:M:S:', \%para);

if ( (!defined($para{'n'})) ||
     (!defined($para{'f'})) ||
     (!defined($para{'m'})) ||
     (!defined($para{'s'})) ||
     (!defined($para{'M'})) ||
     (!defined($para{'S'}))) {
    die ($usage);
}

if ($para{'f'} < 0 || $para{'f'} > 1) {
    die ("f out of range\n$usage");
}


my $d1_num = &round ($para{'f'} * $para{'n'});
my $d2_num = $para{'n'} - $d1_num;

#die ("d1 $d1_num d2 $d2_num");

my (@d1) = random_normal ($d1_num, $para{'m'}, $para{'s'});
my (@d2) = random_normal ($d2_num, $para{'M'}, $para{'S'});

push (@d1, @d2);

foreach my $v (sort {$a <=> $b} @d1) {
    if (defined($para{'r'})) {
	$v = &round($v);
    }
    print "$v\n";
}

sub round {
    my($number) = shift;
    return int($number + .5);
}
