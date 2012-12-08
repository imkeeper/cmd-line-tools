#!/s/std/bin/perl

use strict;

if ($#ARGV != 0) {
  print "$#ARGV Usage chopMail.pl [mail file]\n";
  exit (0);
}

open (IN, "$ARGV[0]") || die ("Couldn't open $ARGV[0]\n");
my $header = 1;
while (my $line = <IN>) {
  if ($line =~ /^From as547\@columbia\.edu\s(.*?)-/) {
    print ( "*****************************************************************\n$1\n");
    $header = 1;
  }

  if ($header == 0) {
    print $line;
  } else {
#    if ( ($line =~ /From: /) || ($line =~ /Subject: /)) {
    if ( ($line =~ /Subject: /)) {
      print $line;
    }
    if ($line =~ /^X-UID/m) {
      $header = 0;
    }
  }
}

close (IN);


#if ($slurp =~ /^X-UID/m) {
#  print ("match1 ");
#}

#$slurp =~ s/From as547\@columbia\.edu.*?(From:\s.*?\s).*?X-UID:\s\d+/*****************************************************************\n$1/sg;
#print $slurp;

#$slurp =~ s/From as547\@columbia\.edu.*?X-UID:\s\d+/*****************************************************************\n$1/sg;
#print $slurp;



