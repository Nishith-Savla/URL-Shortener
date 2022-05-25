<%
    Cookie cookie = null;
    Cookie[] cookies = null;
    cookies = request.getCookies();
    if (cookies != null) {
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

    <link rel="stylesheet" href="src/main/webapp/style.css"/>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        function toggle_password(inputId) {
            const element = document.getElementById(inputId);
            element.getAttribute("type") === "password" ? element.setAttribute("type", "text") : element.setAttribute("type", "password");
        }

        function validateForm() {
            const email_regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

            if (!email_regex.test(myForm.email.value)) {
                Swal.fire({
                    title: 'Login unsuccessful.',
                    text: `Please enter a valid email address.`,
                    icon: 'error',
                });
                return false;
            }

            return true;
        }
    </script>

    <title>Simple URL Shortener</title>

    <link rel="icon" href="src/main/webapp/img/logo.png" type="image/icon type"/>
</head>
<body>
<!-- Start Of Header -->
<div class="container header">
    <div class="row align-items-center">
        <div class="col-md-12">
            <div class="media">
                <a href="/URL-Shortener/" class="">
                    <img src="src/main/webapp/img/big-logo.png" class="nav-img-login mx-auto d-block"/>
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
            <form action="/cgi-bin/login_validate.cgi" method="post" onsubmit="return validateForm()" name="myForm">
                <div class="my-5  px-5 login-fm">
                    <h1 class="login-header">
                        Login
                    </h1>

                    <label for="email" class="form-label login-fm-lb">Email</label>
                    <input type="email" id="email" name="email" class="form-control login-box"
                           placeholder="Please Enter Your Email Id" aria-describedby="email" required>

                    <label for="password" class="form-label login-fm-lb">Password</label>
                    <input type="password" id="password" name="password" class="form-control login-box"
                           placeholder="Please Enter Your Password" aria-describedby="helpId" required>

                    <span>
                                <i class="fas fa-eye" style="position:absolute; right:582px; bottom:262px;"
                                   onclick="toggle_password('password')"></i>
                            </span>
                    <div class="login-fm-lk text-center">
                        <a href="register" class="login-fm-lk">
                            Don't have an account? Sign Up.
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

<!-- End of Login Form -->
</body>
</html>