#!C:\xampp\perl\bin\perl.exe

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
if (!($url =~ qr/^https?:\/\//)) {
    $url = "http://" . $url;
}

my $email = cookie("EMAIL");
my $uniqueURL = $email . ":" . $url;
my $shortened = crc32($uniqueURL);
my $date = DateTime->now;

$shortened = sprintf("%x", $shortened); # Convert int to hex

my $con = DBI->connect('DBI:mysql:urlshortener:localhost', $ENV{'MYSQL_USERNAME'}, $ENV{'MYSQL_PASSWORD'}) 
or die "Can't connect to database $DBI::errstr";

my $select_query_og = $con->prepare("SELECT shortened, original FROM urls WHERE original = ? AND user_email = ?")
    or die "Can't prepare statement $DBI::errstr";

my $rows_selected_og = $select_query_og->execute($url, $email)
    or die "Can't execute statement $DBI::errstr";

if ($rows_selected_og > 0) {
    ($shortened, $url) = $select_query_og->fetchrow();
    $select_query_og->finish();
} else {
    $select_query_og->finish();
    my $select_query = $con->prepare("SELECT shortened FROM urls WHERE shortened = ?")
        or die "Can't prepare statement $DBI::errstr";

    my $rows_selected = $select_query->execute($shortened)
        or die "Can't execute statement $DBI::errstr";

    $select_query->finish();

    if ($rows_selected == 0) {
        my $insert_query = $con->prepare("INSERT INTO urls VALUES(?, ?, ?, ?)");
        my $result = $insert_query->execute($shortened, $url, $date, $email);
        $insert_query->finish();
    }
}

print "<form id='miForm' method='post' action='\\URL-Shortener\\shorten'>
    <input type='hidden' name='shortenedURL' value='$shortened'>
    <input type='hidden' name='originalURL' value='$url'></form>

    <script type='text/javascript'>
        document.getElementById('miForm').submit();
    </script>";
print end_html;

$con->disconnect;
