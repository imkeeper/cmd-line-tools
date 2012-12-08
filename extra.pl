
use strict;

# generates a random shuffle of an array
# from perl cookbook
sub fisher_yates_shuffle {
    my $array = shift;
    my $i;
    for ($i = @$array; --$i;) {
	my $j = int rand ($i+1);
	next if ($i == $j);
	@$array[$i,$j] = @$array[$j,$i];
    }
}

sub cmp_ip {
#  my ($a, $b) = @_;
  my @aElements = ();
  if ($a =~ /(\d+)\.(\d+)\.(\d+)\.(\d+)/) {
    $aElements[0] = $1;
    $aElements[1] = $2;
    $aElements[2] = $3;
    $aElements[3] = $4;
  } else {
    die ("Invalid IP address passed into cmp_ip: $a");
  }
  my @bElements = ();
  if ($b =~ /(\d+)\.(\d+)\.(\d+)\.(\d+)/) {
    $bElements[0] = $1;
    $bElements[1] = $2;
    $bElements[2] = $3;
    $bElements[3] = $4;
  } else {
    die ("Invalid IP address passed into cmp_ip: $b");
  }
  for (my $i = 0; $i < 4; $i++) {
    if ($aElements[$i] > $bElements[$i]) {
      return 1;
    } elsif ($bElements[$i] > $aElements[$i]) {
      return -1;
    }
  }
  return 0;
}

sub substitute {
  my ($template, $filler) = @_;
  my $tmpl = $template;

#  print "$filler \n";

  foreach my $key (keys %$filler) {
#    print "k $key\n";

    $tmpl =~ s/$key/$filler->{$key}/g;
  }
  return $tmpl;
}

1;
