#!C:\xampp\perl\bin\perl.exe

use CGI ':standard';
use DBI;

$first_name = param('first_name');
$last_name = param('last_name');
$gender = param('gender');
@hobbies_arr=param("hobbies");

$hobbies = join(',', @hobbies_arr);

print header,
start_html (-title=>"Welcome " . $first_name . " " . $last_name),
h1 ("You have choosen $gender as your gender and you said you love $hobbies");

$myConnection = DBI->connect('DBI:mysql:tyco:localhost', 'root', 'pass');
$query= $myConnection->prepare("INSERT INTO students(first_name, last_name, gender, hobbies) VALUES('$first_name','$last_name','$gender','$hobbies')");
$result = $query->execute();
$query->finish();
# print $result;

$select_query = $myConnection->prepare("SELECT * FROM students");
$result1 = $select_query->execute();
$select_query->finish();
print $result1;

