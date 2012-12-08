#!/usr/bin/perl

use strict;

#my $queueDirs = $ARGV[0];
#my (@dirs) = split (/\s+/,$queueDirs);

foreach my $dir (@ARGV) {

    chdir $dir or die ("Cannot chdir to $dir");

    my $week = 7*24*60*60;

    opendir INDIR, "." or die ("Cannot open dot");
    my (@allFiles) = readdir (INDIR);
    closedir INDIR;

    my $currentTime = time;

    my $rmCount = 0;

    foreach my $file (@allFiles) {
	if ($file =~ /^ask\.msg\./) {
	    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
		$atime,$mtime,$ctime,$blksize,$blocks)
		= stat($file);
	    if ($mtime < $currentTime - $week) {
		#print "rm   $file\n";
		unlink ($file) or die ("Cannot unlink $file");
		$rmCount++;
	    } else {
		#print "keep $file\n";
	    }

	} else {
	    #warn "$file does not match\n";
	}
    }

    print "$dir: removed $rmCount files\n";
}
