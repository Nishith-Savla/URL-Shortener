<%
  Cookie cookie = null;
  Cookie[] cookies = null;
  boolean login =false;
  cookies = request.getCookies();
  if( cookies != null )
  {

    for (int i = 0; i < cookies.length; i++) {
      cookie = cookies[i];

      if (cookie.getName().equals("EMAIL") && cookie.getValue() != "") {
        login = true;

        break;
      }
    }
  }
%>
<!DOCTYPE html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />

    <!-- Bootstrap CSS v5.0.2 -->
      <link rel="stylesheet" href="src/main/webapp/bootstrap/bootstrap.min.css"  >

      <script src="src/main/webapp/bootstrap/bootstrap.bundle.min.js" ></script>

      <link rel="stylesheet" href="src/main/webapp/style.css" />

      <title>Simple URL Shortener</title>

      <link rel="icon" href="src/main/webapp/img/logo.png" type="image/icon type" />
      <script src="src/main/webapp/main.js" ></script>
  </head>
  <body>
      <!-- Start Of Header -->
    <div class="container header">
        <div class="row align-items-center">
          <div class="col-md-3">
            <div class="media">
              <a href="" class="nav_thing"
                ><img src="src/main/webapp/img/big-logo.png" class="nav-img mx-auto d-block"
              /></a>
            </div>
          </div>
          <div class="col-md-6 nav_thing text-center">

          </div>
          <div class="col-md-3 text-center account-head-dv">
            
          <%
          if(!(login))
          {
        %>
          <a href="src/login.jsp" class="account-head">Login</a> &nbsp; &nbsp; | &nbsp;&nbsp;
          <a href="src/register.jsp" class="account-head">Sign Up</a>
        <%
          }
          else {
            out.println("<a href=\"src/myaccount.jsp\" class=\"account-head\">My Account</a> &nbsp; &nbsp; | &nbsp;&nbsp;");
            out.println("<a href=\"src/logout.jsp\" class=\"account-head\"> Logout</a>");
          }
        %>





          </div>
        </div>
      </div>
      <!-- End Of Header -->
        <div class="container"> 
            <div class="row align-items-center shorten-body">
              <div class="col-md-3"></div>
              <div class="col-md-6">
                 <h2 class="main-title">Original link</h2>
                 <div class="og-link mb-5"><%= request.getParameter("main") %></div>
                 
                  <div class="mb-3">
                    <h2 class="main-title">Shortened Link</h2>
                    <div class="input-group new-div">
                      <span class="form-control new-link text-center">
                          <span class="my-3 d-block new-link-title" id="new-link-title"><%= request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/s/" %></span>
                      
                      </span>
                      <input class="form-control" type="text" id="editbox"  value='temp'  required/>
                      <button class="btn px-2 edit-btn" title="copy" onclick='copy_to_clipboard("<%= request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/s/" %>","editbox")'>
                        <i class="bi bi-files"></i>
                      </button>

                      <div class="input-group-append">
                        <button class="btn px-3" id="save-btn" title="save">
                              <i class="bi bi-box-arrow-right"></i>
                        </button>
                      </div>
                    </div>
                      <%
                          Boolean linkIsInUse = false;
                          if(linkIsInUse)
                          {
                      %>
                      <div class="alert alert-warning my-3" role="alert">
                          The link you have selected is already in use!!
                      </div>
                      <script>
                            in_use_alert()
                      </script>
                      <%
                          }
                      %>
                  </div>
              </div>
              <div class="col-md-3"></div>
            </div>
        </div>
        <!-- Start of Footer -->
        <div class="container">
            <div class="row foot-row">
            <div class="col-md-4">
                <div class="foot-t">Information</div>

                <a href="#" class="foot-lk">About us</a><br />
                <a href="#" class="foot-lk">Billing Information</a><br />
                <a href="#" class="foot-lk">Privacy & Policy</a><br />
                <a href="#" class="foot-lk">Terms & Condition</a><br />
                <a href="#" class="foot-lk">Data Policies</a><br />
            </div>

            <div class="col-md-4">
                <div class="foot-t">Socials</div>

                <a href="#" class="foot-lk"
                >Instagram&nbsp;&nbsp;&nbsp;<i class="bi bi-instagram"></i></a
                ><br />
                <a href="#" class="foot-lk"
                >Twitter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i
                    class="bi bi-twitter"
                ></i></a
                ><br />
                <a href="#" class="foot-lk"
                >Facebook&nbsp;&nbsp;&nbsp;&nbsp;<i class="bi bi-facebook"></i></a
                ><br />
                <a href="#" class="foot-lk"
                >Discord&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i
                    class="bi bi-discord"
                ></i></a
                ><br />
                <a href="#" class="foot-lk"
                >Reddit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i
                    class="bi bi-reddit"
                ></i></a
                ><br />
            </div>

            <div class="col-md-4">
                <div class="foot-t">About Us</div>
                <div class="foot-lk">
                We are a modern link shortening company focused on developing
                solutions that are fast and efficient!
                </div>
                <div class="foot-lk">
                We are fiercely committed to our customers' success. Our job is to
                ensure that our trusted platform, performance, and people help
                customers achieve their goals.
                </div>
            </div>
            </div>
        </div>
        <!-- End of Footer -->
  </body>
</html>
