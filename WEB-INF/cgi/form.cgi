#!/usr/bin/perl

use CGI ":standard";

print header;

print '
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>Form Example with CGI</title>
</head>
<body>
    <form action="form_submit.cgi" method="post" class="container">
        First Name:
        <input type="text" name="first_name" class="my-2" ><br>
        Last Name:
        <input type="text" name="last_name" class="my-2" ><br>
        Gender:
        <select name="gender" id="gender" class="my-2" >
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
        </select><br/>
        Hobby:
        <select name="hobbies" id="hobby" class="my-2" >
            <option value="dancing">Dancing</option>
            <option value="singing">Singing</option>
            <option value="gaming">Gaming</option>
        </select><br/>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</body>
</html>'
