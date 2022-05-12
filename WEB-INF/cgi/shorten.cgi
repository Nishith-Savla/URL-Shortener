#!C:\xampp\perl\bin\perl.exe -w

use CGI ":standard";
use CGI::Cookie;
use DateTime;
use DBI;
use String::CRC32;
use warnings;
use strict;

sub get_current_domain {
    my $page_url = 'http';
    if (exists $ENV{HTTPS} && $ENV{HTTPS} eq "on") {
        $page_url .= "s";
    }
    $page_url .= "://" . $ENV{SERVER_NAME} . ":" . $ENV{SERVER_PORT};
    return $page_url;
}

print header, start_html(-title=>"Shortened | Simple URL Shortener");

my $url = param("url");
my $urlregex = qr/[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#\?&\/\/=]*)/;
if (!($url =~ $urlregex)) {
    print "Invalid URL";
    print end_html;
    return;
}
$url =~ s|/$||;

my $uniqueURL = cookie("EMAIL") . ":" . $url;
my $crc = crc32($uniqueURL);
my $date = DateTime->now;

$crc = sprintf("%x", $crc); # Convert int to hex

my $con = DBI->connect('DBI:mysql:urlshortener:localhost', $ENV{'MYSQL_USERNAME'}, $ENV{'MYSQL_PASSWORD'}) 
or die "Can't connect to database $DBI::errstr";

my $select_query = $con->prepare("SELECT shortened FROM urls WHERE shortened = ?")
or die "Can't prepare statement $DBI::errstr";

my $rows_selected = $select_query->execute($crc)
or die "Can't execute statement $DBI::errstr";

$select_query->finish();

if ($rows_selected == 0) {
    my $insert_query = $con->prepare("INSERT INTO urls VALUES(?, ?, ?)");
    my $result = $insert_query->execute($crc, $url, $date);
    $insert_query->finish();
}

print get_current_domain . "/s/" . $crc;

print end_html;
$con->disconnect;
