#!/usr/bin/perl -w

# Copyright 2000, Andreas Widmann (widmann@rz.uni-leipzig.de)
#
# This script is free software; permission to use, copy, modify, and
# distribute this software and its documentation for any purpose without
# fee is hereby granted, provided that both the above copyright notice
# and this permission notice appear in all copies and in supporting
# documentation.
#
# This software is provided "as is" without express or implied warranty
# of any kind.

#introstuff
sub usage_info() {
  print "boxfill.pl\n";
  print "  fills (and outlines) boxes in gnuplot 3.7.1 postscript files\n";
  print '  $Id: boxfill.pl,v 1.1 2004/01/13 19:29:10 jonathan Exp $', "\n";
  print "usage:\n";
  print "  boxfill.pl [-o] [-r] [-z] <ps_in> <ps_out>\n";
  print "options:\n";
  print "  -o         draw outline\n";
  print "  -r         remove \"currentpoint stroke M\" (experimental!)\n";
  print "  -z         outline zero height boxes (experimental!)\n";
  print "arguments:\n";
  print "  <ps_in>    postscript input file\n";
  print "  <ps_out>   postscript output file\n";
}
if ($#ARGV < 1) {
  &usage_info();
  exit(0);
}
$outlinestyle = 'LTb';
if(grep(/^-o$/, @ARGV) == 1) { $outline = "\ngsave\ncurrentpoint $outlinestyle M redo stroke\ngrestore" }
else { $outline = '' }

#read input file
open(IN, $ARGV[$#ARGV - 1]) || die "Cannot open $ARGV[$#ARGV - 1]\n";
$content = join('', <IN>);
close(IN);

#search patterns
$key = '(-*\d+ -*\d+ M\n)(-*\d+)( -*\d+ V\n)(-*\d+ -*\d+ [RM]\n-*\d+ -*\d+ V\n-*\d+ -*\d+ V\n-*\d+ -*\d+ V\n-*\d+ -*\d+ V\n)';
#$key = '(-*\d+ -*\d+ M\n)(-*\d+)( -*\d+ V\n)(-*\d+ -*\d+ [RM]\n-*\d+ -*\d+ V\n-*\d+ -*\d+ V\n)'; #experimental
$box = '(?<!LTb)(\n-*\d+ -*\d+ [RM]\n)(-*\d+ -*\d+ V\n-*\d+ -*\d+ V\n-*\d+ -*\d+ V\n-*\d+ -*\d+ V)';
#$box = '(?<!LTb)(\n-*\d+ -*\d+ [RM]\n)(-*\d+ -*\d+ V\n-*\d+ -*\d+ V\n-*\d+ -*\d+ [LV]\n-*\d+ -*\d+ V)'; #experimental

#substitute comments
$content =~ s/(%%Title: ).*$/$1$ARGV[$#ARGV]/m;
$content =~ s/(%%Creator: ).*$/$1boxfill.pl 0.2/m;
$content =~ s/(%%CreationDate: ).*$/$1.localtime()/em;

#remove "currentpoint stroke M"
if(grep(/^-r$/, @ARGV) == 1) { $content =~ s/\ncurrentpoint stroke M\n/\n/g }

#substitute boxplot commands
$content =~ s/$key/$1gsave\n\/redo \{0 vpt 2 div V $2 0 V 0 vpt neg V $2 neg 0 V closepath\} bind def\ncurrentpoint stroke M redo fill\ngrestore$outline\n$2 0 R\n$4/g;
$content =~ s/$box/$1gsave\n\/redo\{$2\} bind def\ncurrentpoint stroke M redo fill\ngrestore$outline/g;

#outline zero height boxes
if(grep(/^-z$/, @ARGV) == 1) {
  $boxshort = '(?<!LTb)(\n-*\d+ -*\d+ [RM]\n)(-*\d+ -*\d+ V\n-*\d+ -*\d+ V)(?!\n.*V\n)';
  $content =~ s/$boxshort/$1gsave\n\/redo\{$2\} bind def\ncurrentpoint stroke M redo fill\ngrestore$outline/g;
}

#write to output file
open(OUT, ">$ARGV[$#ARGV]") || die "Cannot open $ARGV[$#ARGV]\n";
print OUT "$content";
close(OUT);
