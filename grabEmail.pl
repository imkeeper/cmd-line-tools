#!/usr/bin/perl

use strict;

# takes some text as input and then prints out *whatever* is between pairs of '<' and '>'

while (my $line = <>) {
    my (@items) = split (/\</, $line);
    for (my $i = 0; $i <= $#items; $i++) {
	if ($items[$i] =~ /(.*?)\>/) {
	    my $email = $1;
	    print "$email\n";
	}
    }
}
