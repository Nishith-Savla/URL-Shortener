#!/usr/bin/perl
#!c:\xampp\perl\bin\perl.exe

use CGI ':standard';
use CGI::Cookie;
use Crypt::Eksblowfish::Bcrypt;
use DBI;
use strict;

my $email = param('email');
my $password = param('password');
# print $email, $password;

# Encrypt a password 
sub encrypt_password {
    my $password = shift;

    # Generate a salt if one is not passed
    my $salt = shift || salt(); 

    # Encrypt the password 
    my $hash = Crypt::Eksblowfish::Bcrypt::bcrypt_hash({
            key_nul => 1,
            cost => 8,
            salt => $salt,
        }, $password);

    # Return the salt and the encrypted password
    return join('-', $salt, Crypt::Eksblowfish::Bcrypt::en_base64($hash));
}

# Check if the passwords match
sub check_password {
    my ($plain_password, $hashed_password) = @_;
    my ($salt) = split('-', $hashed_password, 2);
    return length $salt == 16 && encrypt_password($plain_password, $salt) eq $hashed_password;
}

# Return a random salt
sub salt {
    my $itoa64 = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    my $salt = '';
    $salt .= substr($itoa64,int(rand(64)),1) while length($salt) < 16;
    return $salt;
}

my $con = DBI->connect('DBI:mysql:urlshortener:localhost', $ENV{MYSQL_USERNAME}, $ENV{MYSQL_PASSWORD});
my $select_query = $con->prepare("SELECT email, password FROM users where email = ? ");
my $result = $select_query->execute($email);

my ($email_from_db, $password_from_db) = $select_query->fetchrow();

$select_query->finish();

if ($email_from_db ne $email) {
    print header;
    print "
    <script>
        alert(`Couldn't found record. Please register.`);
        location.replace('/URL-Shortener/login');
    </script>
    ";
}

if (!check_password($password, $password_from_db)) {
    print header;
    print "
    <script>
        alert(`Login Unsuccessful. Invalid Password`);
        location.replace('/URL-Shortener/login');
    </script>
    ";
}    

my $c = CGI::Cookie->new(
                -name    =>  'EMAIL',
                -value   =>  $email,
                -expires =>  '+1H',
                -samesite=>  "Lax"
            );

print header(-cookie=>$c);
print "Login Successful";
print "
<script>
    alert(`Login successful.`);
    location.replace('/URL-Shortener/');
</script>
";
