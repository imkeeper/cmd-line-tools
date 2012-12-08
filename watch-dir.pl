#!/usr/bin/perl

# Written by Jonathan Ledlie

use strict;
use Getopt::Std;
use Mail::Mailer;

my $usage = "watch-dir.pl \n".
    "  -d directory\n".
    "  -p period in seconds: how often to look at the directory\n".
    "  -t email address of recipient (to)\n".
    "  -f email address of sender (from)\n".
    "  -s subject\n".
    " Mails out the names of new files that appear in a directory.\n";

my %para = ();
getopts('d:p:f:t:s:', \%para);

if (!defined($para{'d'}) ||
    !defined($para{'p'}) ||
    !defined($para{'f'}) ||
    !defined($para{'t'}) ||
    !defined($para{'s'})) {
    die ($usage);
}

my $dir = $para{'d'};
my $period = $para{'p'};
my $recipient = $para{'t'};
my $sender = $para{'f'};
my $subject = $para{'s'};

my $list_filename = 'watch-dir-list.txt';
my $list_file = $dir.'/'.$list_filename;

my %files = ();

$files{'.'} = 1;
$files{'..'} = 1;
$files{$list_filename} = 1;

if (-e $list_file) {
    open IN, $list_file or die ("Cannot open $list_file");
    while (my $line = <IN>) {
	chop ($line);
	$files{$line} = 1;
    }
    close IN;
}

while (1) {

    opendir INDIR, "$dir" or die ("Cannot open $dir");
    my (@all_files) = readdir (INDIR);
    closedir INDIR;

    my $is_new = 0;
    my @new_files = ();
    foreach my $file (@all_files) {
	if (!defined($files{$file})) {
	    warn "new file $file\n";
	    $files{$file} = 1;
	    $is_new = 1;
	    push (@new_files, $file);
	}
    }

    if ($is_new) {

	&send_email (\@new_files);
	&write_file_list ();

    }

    sleep ($period);

}

sub write_file_list {
    open OUT, ">$list_file" or die ("Cannot open $list_file for writing");
    foreach my $file (sort keys %files) {
	print OUT "$file\n";
    }
    close OUT;
}

sub send_email {
    my ($new_files) = @_;

    my $body = 'New files:\n';
    foreach my $file (@$new_files) {
	$body .= $file . "\n";
    }

    my $mailer = Mail::Mailer->new("sendmail");
    #my $mailer = Mail::Mailer->new();
    $mailer->open({ From => $sender,
		    To   => $recipient,
		    Subject => $subject,
		  })
	or die ("Cannot open $!\n");
    print $mailer $body;
    $mailer->close();
}
