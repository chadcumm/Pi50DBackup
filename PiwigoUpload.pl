#!/usr/bin/perl

# perl piwigo_remote.pl --action=pwg.images.add --file=erwann_rocher-web.jpg
 
use LWP::UserAgent;
use Getopt::Long;
use POSIX 'strftime';

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

$date = strftime '%Y-%m-%d', localtime;
 
$response = $ua->post(
    $conf{base_url}.'/ws.php',
    {
        method => 'pwg.images.addSimple',
        image => [$opt{file}],
        category => 187,
        tags => 'canon50D',
        name => '',
        comment => '',
	date_creation => $date, 
        author => 'Canon50D',
        level => 0,
    },
    'Content_Type' => 'form-data',
);

print "-" x 50, "\n";
printf("response code    : %u\n", $response->code);
printf("response message : %s\n", $response->message);
print "-" x 50, "\n";
print "\n";
 
if ($response->is_success) {
    print "upload successful\n";
    $result = `sudo rm -f $opt{file}`;

}
else {
    die $response->status_line;
}
