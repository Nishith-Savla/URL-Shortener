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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS v5.0.2 -->
    <link rel="stylesheet" href="src/main/webapp/bootstrap/bootstrap.min.css"  >
    
    <script src="src/main/webapp/bootstrap/bootstrap.bundle.min.js" ></script>

    <link rel="stylesheet" href="src/main/webapp/style.css" />

    <title>Simple URL Shortener</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

    <link rel="icon" href="src/main/webapp/img/logo.png" type="image/icon type" />
    <!-- <script src="src/main/webapp/main.js" ></script> -->
    </head>
  <body>
    <!-- Start Of Header -->
    <div class="container header head-boda">
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
    
    <!-- Start of main body -->

    <div class="container analytics-body">
      <div class="row align-items-center">
        <div class="col-md-2 left-menu">
            
            <ul class="nav nav-pills flex-column mt-4">
              <li class="nav-item ">
                <a href="#" class="nav-link py-3">My Profile</a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link py-3">My Links</a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link py-3 active ">Analytics</a>
              </li>
            </ul>
            
        </div>
        <div class="col-md-10">
            <div class="charts-body mx-4 p-3">
              <div class="row text-center">
                <div class="col-md-4">
                  <h2 class="chart-header">Continent</h2>
                    <div class="chart-container">                
                      <canvas id="continent" style=" width:100%; height: 100%;"></canvas>
                      <script>
                        var xValues = ["Asia","Europe","North America", "South America"];
                        var yValues = [55, 49, 44, 24];
                        var barColors = [
                          "#b762c1",
                          "#c87bd1",
                          "#ea99d5",
                          "#ffcddd"
                        ];

                        new Chart("continent", {
                          type: "pie",
                          data: {
                            labels: xValues,
                            datasets: [{
                              backgroundColor: barColors,
                              data: yValues
                            }]
                          },
                          options: {
                            
                          }
                        });
                      </script>
                    </div>
                  
                </div>
                <div class="col-md-4">
                  <h2 class="chart-header">
                    Operating System
                  </h2>
                  <div class="chart-container">                
                    <canvas id="os" style=" width:100%; height: 100%;"></canvas>
                    <script>
                      var xValues = ["Windows","Linux","MacOs", "Other"];
                      var yValues = [69, 20, 49, 5];
                      var barColors = [
                        "#6e7df0",
                        "#eb838a",
                        "#ebe883",
                        "#8f8f8f"
                      ];

                      new Chart("os", {
                        type: "doughnut",
                        data: {
                          labels: xValues,
                          datasets: [{
                            backgroundColor: barColors,
                            data: yValues
                          }]
                        },
                        options: {
                          
                        }
                      });
                    </script>
                  </div>
                </div>
                <div class="col-md-4">
                  <h2 class="chart-header">
                    Browser
                  </h2>
                  <div class="chart-container">                
                    <canvas id="browser" style=" width:100%; height: 100%;"></canvas>
                    <script>
                      var xValues = ["Edge","Chrome","Safari", "Firefox","Other"];
                      var yValues = [69,100, 20, 49, 5];
                      var barColors = [
                        "#33ccff",
                        "#ffcc00",
                        "#99ff99",
                        "#ff9900",
                        "#8f8f8f"
                      ];

                      new Chart("browser", {
                        type: "pie",
                        data: {
                          labels: xValues,
                          datasets: [{
                            backgroundColor: barColors,
                            data: yValues
                          }]
                        },
                        options: {
                          
                        }
                      });
                    </script>
                  </div>
                </div>
              </div>
              <div class="row text-center">
                <div class="col-md-12">
                  <div class="chart-container-visits pt-5">
                    <canvas id="visits" style="width:100%;  height:100%;"></canvas>

                    <script>
                    var xValues = ["January","February","March","April","May","June","July","August","September","November","December"];
                    var yValues = [7,8,8,9,9,9,10,11,10,14,15];
                    
                    new Chart("visits", {
                      type: "line",
                      data: {
                        labels: xValues,
                        datasets: [{
                          fill: false,
                          lineTension: 0,
                          backgroundColor: "rgba(0,0,255,1.0)",
                          borderColor: "rgba(0,0,255,0.1)",
                          data: yValues
                        }]
                      },
                      options: {
                        legend: {display: false},
                        scales: {
                          yAxes: [{ticks: {min: 6, max:16}}],
                        }
                      }
                    });
                    </script>
                  </div>
                  <h2 class="chart-header">
                    No of visits
                  </h2>
                  
                </div>
              </div>
              
            </div>
        </div>
      </div>
    </div>

    <!-- End of main Body -->
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

    <!-- End of main body -->

    
    </body>
  </html>
  