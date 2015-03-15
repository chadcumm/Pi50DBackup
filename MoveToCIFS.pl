#!/usr/bin/perl

# perl MoveToCIFS.pl  --file=erwann_rocher-web.jpg
 
use LWP::UserAgent;
use Getopt::Long;

my %opt = ();
GetOptions(
    \%opt,
    qw/
          file=s
      /
);

$response = `mv $opt{file} /mnt/our_bible/Pi50DBackup/ 2>&1`;

printf($response);

