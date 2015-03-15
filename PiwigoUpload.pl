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
 
$response = $ua->post(
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

print "-" x 50, "\n";
printf("response code    : %u\n", $response->code);
printf("response message : %s\n", $response->message);
print "-" x 50, "\n";
print "\n";
 
if ($response->is_success) {
    print "upload successful\n";
}
else {
    warn 'A problem has occured during upload', "\n";
    warn $response->decoded_content, "\n";
    die $response->status_line;
}
