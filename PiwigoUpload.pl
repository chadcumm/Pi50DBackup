#!/usr/bin/perl

# perl piwigo_remote.pl --action=pwg.images.add --file=erwann_rocher-web.jpg --define categories=9
 
use LWP::UserAgent;
use Getopt::Long;

my %opt = ();
GetOptions(
    \%opt,
    qw/
          action=s
          file=s
          categories=s
      /
);
 
my %conf = (
    base_url => 'http://media.stewartcummings.com',
);
 
my $ua = LWP::UserAgent->new;
$ua->cookie_jar({});
 
$ua->post(
    $conf{base_url}.'/ws.php',
    {
        method => 'pwg.session.login',
        username => 'canon50D',
        password => 'uploadpics',
    }
);
 
$ua->post(
    $conf{base_url}.'/ws.php',
    {
        method => 'pwg.images.addSimple',
        image => [$opt{file}],
        category => 187,
        tags => 'canon50D',
        name => '',
        comment => '',
        author => 'Canon50D',
        level => 0,
    },
    'Content_Type' => 'form-data',
);
