<%
    Cookie cookie = null;
    Cookie[] cookies = null;
    cookies = request.getCookies();
    if( cookies != null )
    {
        for (int i = 0; i < cookies.length; i++) {
            cookie = cookies[i];
            if (cookie.getName().equals("EMAIL") && cookie.getValue() != "") {
                response.sendRedirect("/URL-Shortener");
                break;
            }
        }
    }

%>
<!DOCTYPE html>
<html>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS v5.0.2 -->
    <link rel="stylesheet" href="src/main/webapp/bootstrap/bootstrap.min.css">

    <script src="src/main/webapp/bootstrap/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="src/main/webapp/style.css" />

    <title>Simple URL Shortener</title>

    <link rel="icon" href="src/main/webapp/img/logo.png" type="image/icon type" />
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>

        function toggle_password(inputId) {
            const element = document.getElementById(inputId);
            element.getAttribute("type") === "password" ? element.setAttribute("type", "text") : element.setAttribute("type", "password");
        }

        function validateForm(event) {
            event.preventDefault();
            const name_regex = /^[a-zA-Z]+( [a-zA-Z]+)?$/;
            const email_regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            const password_regex = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})/;

            if (!name_regex.test(myForm.name.value)) {
                Swal.fire({
                    title: 'Registration unsuccessful.',
                    text: `Please enter a valid name(containing only alphabets and spaces).`,
                    icon: 'error',
                });
                return false;
            }

            if (!email_regex.test(myForm.email.value)) {
                Swal.fire({
                    title: 'Registration unsuccessful.',
                    text: `Please enter a valid email address.`,
                    icon: 'error',
                });
                return;
            }

            if (!password_regex.test(myForm.password.value)) {
                Swal.fire({
                    title: 'Registration unsuccessful.',
                    text: `Please enter a password greater than 8 characters including atleast 1 uppercase, 1 lowercase, 1 digit and 1 special character.`,
                    icon: 'error',
                });
                return;
            }

            if (myForm.password.value !== myForm.confirm_password.value) {
                Swal.fire({
                    title: 'Registration unsuccessful.',
                    text: `Passwords are not matching`,
                    icon: 'error',
                });
                return;
            }

            event.currentTarget.submit();
        }
    </script>
    
</head>

<body>
    <!-- Start Of Header -->
    <div class="container header">
        <div class="row align-items-center">
            <div class="col-md-12">
                <div class="media">
                    <a href="/URL-Shortener/" class="">
                        <img src="src/main/webapp/img/big-logo.png" class="nav-img-login mx-auto d-block" />
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- End Of Header -->
    <!-- Start Of Login form -->
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-4"></div>
            <div class="col-md-4 ">
                <form action="URL-shortener/register_validate.cgi" method="post" class="needs-validation" name="myForm">
                    <div class="my-5  px-5 login-fm">
                        <h1 class="login-header">
                            Sign Up
                        </h1>

                        <label for="name" class="form-label login-fm-lb">Name</label>
                        <input type="name" name="name" id="name" class="form-control login-box"
                            placeholder="Please Enter Your Name " aria-describedby="name" required>

                        <label for="email" class="form-label login-fm-lb">Email</label>
                        <input type="name" name="email" id="email" class="form-control login-box"
                            placeholder="Please Enter Your Email Id" aria-describedby="email" required>

                        <label for="password" class="form-label login-fm-lb">Password</label>
                        <input type="password" name="password" id="password" class="form-control login-box"
                            placeholder="Please Enter Your Password" aria-describedby="password" required>
                        <span>
                            <i class="fas fa-eye" style="position:absolute; right:590px; bottom:145px;"
                                onclick="toggle_password('password')"></i>
                        </span>

                        <label for="confirm_password" class="form-label login-fm-lb"> Re-enter Password</label>
                        <input type="password" name="confirm_password" id="confirm_password"
                            class="form-control login-box" placeholder="Please Enter Your Password"
                            aria-describedby="confirm_password" required>
                        <span>
                            <i class="fas fa-eye" style="position:absolute; right:590px; bottom:26px;"
                            onclick="toggle_password('confirm_password')"></i>
                        </span>

                        <div class="login-fm-lk text-center">
                            <a href="login" class="login-fm-lk">
                                Already have an account? Login.
                            </a>
                        </div>

                        <button type="submit" class="btn login-sub">Submit</button>
                    </div>
                </form>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
    <script src="https://kit.fontawesome.com/f1e397c55b.js" crossorigin="anonymous"></script>
    <script>
        const form = document.querySelector('form');
        form.addEventListener('submit', validateForm);
    </script>
    <!-- End of Login Form -->
</body>

</html>