#!/usr/bin/perl

use strict;
use Getopt::Std;

my $license_file = '';
my $tmp_file = "/tmp/out.txt";
my $tmp_hash_file = "/tmp/license-hash.txt";
my $tmp_cpp_file = "/tmp/license-cpp.txt";

my %para = ();
getopts('l:', \%para);
if (defined($para{'l'})) {
    $license_file = $para{'l'};
} else {
    die ("License header required");
}

######################################################################

my @license = ();
open IN, $license_file or die ("Cannot open license file");
while (my $line = <IN>) {
    chop ($line);
    push (@license, $line);
}
close IN;

open OUT_HASH, ">$tmp_hash_file" or die ("Cannot open $tmp_hash_file");
open OUT_CPP, ">$tmp_cpp_file" or die ("Cannot open $tmp_cpp_file");
print OUT_CPP "/*\n";
foreach my $line (@license) {
    print OUT_CPP " * ".$line."\n";
    print OUT_HASH "# ".$line."\n";
}
print OUT_CPP " */\n";
close OUT_CPP;
close OUT_HASH;

#die ("stopping");

######################################################################

opendir INDIR, "." or die ("Cannot open dot");
my (@allFiles) = readdir (INDIR);
closedir INDIR;



foreach my $file (@allFiles) {
    print "$file\n";

    my $tmp_license_file = "";
    if ($file =~ /\.sql/) {
	$tmp_license_file = $tmp_hash_file;
    } elsif ($file =~ /\.java/) {
	$tmp_license_file = $tmp_cpp_file;
    } elsif ($file =~ /\.cpp/) {
	$tmp_license_file = $tmp_cpp_file;
    } elsif ($file =~ /\.h/) {
	$tmp_license_file = $tmp_cpp_file;
    } else {
	print "skipping $file\n";
	next;
    }

    unlink ($tmp_file) or die ("Cannot unlink $tmp_file");

    my $cat_cmd = "cat $tmp_license_file $file > $tmp_file";
    system ($cat_cmd) == 0 or die ("Cannot $cat_cmd $?");

    my $cp_cmd = "cp $tmp_file $file";
    system ($cp_cmd) == 0 or die ("Cannot $cp_cmd $?");



}
