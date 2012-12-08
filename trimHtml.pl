#!/usr/bin/perl -w

use strict;

use HTML::TokeParser::Simple;

RemoveTags("$ARGV[0]");

sub RemoveTags {
    my $html_doc=shift;
    my $p = HTML::TokeParser::Simple->new ($html_doc);
  
    while ( my $token = $p->get_token ) {
	print $token->as_is if $token->is_text;
    }
}
