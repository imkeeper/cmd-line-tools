#!/s/std/bin/perl

use strict;

my $line;

$line = <>;
$line =~ s/\t/\n/g;
print $line;

#my @half = split ("\n", $line);
#for (my $index; $index <= $#half; $index++) {
#    if ($half[$index] > 3900 && $half[$index] < 13100) {
#	print "$index $half[$index]\n";
#    }
#}

#for (my $index; $index <= $#half; $index = $index+2) {
#    print "$half[$index]\n";
#}

