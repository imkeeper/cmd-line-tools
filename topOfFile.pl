#!/usr/bin/perl

# usage: perl -w ~/bin/topOfFile.pl ~/bin/copyright.txt *.h *.cc

use strict;

my $fileTop = $ARGV[0];

my $pid = $$;

for (my $arg = 1; $arg <= $#ARGV; $arg++) {
    my $fileCurrent = $ARGV[$arg];

    print "top $fileTop curr $fileCurrent\n";

    my $fileTmp = $fileCurrent.".$pid";

    my $cmd = "cat $fileTop $fileCurrent > $fileTmp";
    system ("$cmd");

    rename $fileTmp, $fileCurrent;

}
