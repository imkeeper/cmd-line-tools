#!/usr/bin/perl

# Jonathan Ledlie

use Math::Random qw(random_uniform_integer);

my $pw_length = 12;

$pw = &rnd_alphanum ($pw_length);

print "$pw\n";

sub rnd_alphanum {
    my ($num_digits) = @_;
    # = last number
    my (@d) = random_uniform_integer($num_digits,0,61);
    my $ret = '';
    for (my $i = 0; $i < $num_digits; $i++) {
	if ($d[$i] <= 9) { $ret .= $d[$i]; next; }
	if ($d[$i] == 10) { $ret .= 'a'; next; }
	if ($d[$i] == 11) { $ret .= 'b'; next; }
	if ($d[$i] == 12) { $ret .= 'c'; next; }
	if ($d[$i] == 13) { $ret .= 'd'; next; }
	if ($d[$i] == 14) { $ret .= 'e'; next; }
	if ($d[$i] == 15) { $ret .= 'f'; next; }
	if ($d[$i] == 16) { $ret .= 'g'; next; }
	if ($d[$i] == 17) { $ret .= 'h'; next; }
	if ($d[$i] == 18) { $ret .= 'i'; next; }
	if ($d[$i] == 19) { $ret .= 'j'; next; }
	if ($d[$i] == 20) { $ret .= 'k'; next; }
	if ($d[$i] == 21) { $ret .= 'l'; next; }
	if ($d[$i] == 22) { $ret .= 'm'; next; }
	if ($d[$i] == 23) { $ret .= 'n'; next; }
	if ($d[$i] == 24) { $ret .= 'o'; next; }
	if ($d[$i] == 25) { $ret .= 'p'; next; }
	if ($d[$i] == 26) { $ret .= 'q'; next; }
	if ($d[$i] == 27) { $ret .= 'r'; next; }
	if ($d[$i] == 28) { $ret .= 's'; next; }
	if ($d[$i] == 29) { $ret .= 't'; next; }
	if ($d[$i] == 30) { $ret .= 'u'; next; }
	if ($d[$i] == 31) { $ret .= 'v'; next; }
	if ($d[$i] == 32) { $ret .= 'w'; next; }
	if ($d[$i] == 33) { $ret .= 'x'; next; }
	if ($d[$i] == 34) { $ret .= 'y'; next; }
	if ($d[$i] == 35) { $ret .= 'z'; next; }

	if ($d[$i] == 36) { $ret .= 'A'; next; }
	if ($d[$i] == 37) { $ret .= 'B'; next; }
	if ($d[$i] == 38) { $ret .= 'C'; next; }
	if ($d[$i] == 39) { $ret .= 'D'; next; }
	if ($d[$i] == 40) { $ret .= 'E'; next; }
	if ($d[$i] == 41) { $ret .= 'F'; next; }
	if ($d[$i] == 42) { $ret .= 'G'; next; }
	if ($d[$i] == 43) { $ret .= 'H'; next; }
	if ($d[$i] == 44) { $ret .= 'I'; next; }
	if ($d[$i] == 45) { $ret .= 'J'; next; }
	if ($d[$i] == 46) { $ret .= 'K'; next; }
	if ($d[$i] == 47) { $ret .= 'L'; next; }
	if ($d[$i] == 48) { $ret .= 'M'; next; }
	if ($d[$i] == 49) { $ret .= 'N'; next; }
	if ($d[$i] == 50) { $ret .= 'O'; next; }
	if ($d[$i] == 51) { $ret .= 'P'; next; }
	if ($d[$i] == 52) { $ret .= 'Q'; next; }
	if ($d[$i] == 53) { $ret .= 'R'; next; }
	if ($d[$i] == 54) { $ret .= 'S'; next; }
	if ($d[$i] == 55) { $ret .= 'T'; next; }
	if ($d[$i] == 56) { $ret .= 'U'; next; }
	if ($d[$i] == 57) { $ret .= 'V'; next; }
	if ($d[$i] == 58) { $ret .= 'W'; next; }
	if ($d[$i] == 59) { $ret .= 'X'; next; }
	if ($d[$i] == 60) { $ret .= 'Y'; next; }
	if ($d[$i] == 61) { $ret .= 'Z'; next; }

	die ("huh");
    }
    return $ret;
}

