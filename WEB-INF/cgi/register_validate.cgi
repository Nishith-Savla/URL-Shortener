#!C:\xampp\perl\bin\perl.exe

use warnings FATAL => 'all';
use CGI ':standard';
use CGI::Cookie;
use Crypt::Eksblowfish::Bcrypt;
use DBI;
use strict;
use constant NAME_REGEX => qr/^[a-zA-Z]+( [a-zA-Z]+)?$/;
use constant EMAIL_REGEX => qr/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
use constant PASSWORD_REGEX => qr/(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})/;

my $name = param('name');
my $email = param('email');
my $password = param('password');

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

my $encrypted_password = encrypt_password($password);

if (!($name =~ NAME_REGEX)) {
    print header, start_html;
    print '<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>';
    print "
<script>
    Swal.fire({
            title: 'Registration unsuccessful.',
            text: 'Please enter a valid name containing only alphabets and spaces.',
            icon: 'error',
    }).then(result => {
        if (result.isConfirmed) {
            location.replace('/URL-Shortener/register');
        }
    })

</script>
", end_html;
    return;
}

if (!($email =~ EMAIL_REGEX)) {
    print header, start_html;
    print '<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>';
    print "
<script>
    Swal.fire({
            title: 'Registration unsuccessful.',
            text: 'Please enter a valid email address.',
            icon: 'error',
    }).then(result => {
        if (result.isConfirmed) {
            location.replace('/URL-Shortener/register');
        }
    })

</script>
", end_html;
    return;
}

if (!($password =~ PASSWORD_REGEX)) {
    print header, start_html;
    print '<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>';
    print "
<script>
    Swal.fire({
            title: 'Registration unsuccessful.',
            text: 'Please enter a password greater than 8 characters including atleast 1 uppercase, 1 lowercase, 1 digit and 1 special character.',
            icon: 'error',
    }).then(result => {
        if (result.isConfirmed) {
            location.replace('/URL-Shortener/register');
        }
    })

</script>
", end_html;
    return;
}

my $con = DBI->connect('DBI:mysql:urlshortener:localhost', $ENV{MYSQL_USERNAME}, $ENV{MYSQL_PASSWORD});
my $query= $con->prepare("INSERT INTO users VALUES(?, ?, ?)");
my $result;
$result = $query->execute($email, $name, $encrypted_password) or $result = 0;
$query->finish();
if ($result == 0) {
    print header, start_html(-title=>"Completing your registration....");
    print '<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>';
    print "
<script>
    Swal.fire({
            title: 'Registration unsuccessful.',
            text: `Email already registered. Try logging in...`,
            icon: 'error',
    }).then(result => {
        if (result.isConfirmed) {
            location.replace('/URL-Shortener/register');
        }
    })

</script>
", end_html;
    return;
}

my $c = CGI::Cookie->new(
            -name    =>  'EMAIL',
            -value   =>  $email,
            -expires =>  '+1M',
            -samesite=>  "Lax"
        );

print header(-cookie=>$c), start_html;
print '<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>';
print "
<script>
    Swal.fire({
            title: 'Registration Succesful!',
            icon: 'success',
    }).then(result => {
        if (result.isConfirmed) {
            location.replace('/URL-Shortener/');
        }
    })

</script>
", end_html;
