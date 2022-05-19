<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.util.HashMap" %>
<%
    boolean login = false;
    final Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("EMAIL") && !cookie.getValue().equals("")) {
                login = true;
                break;
            }
        }
    }
    if(!request.getParameterMap().containsKey("shortened"))
    {
        response.sendRedirect("list");
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

    <title>Simple URL Shortener</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

    <link rel="icon" href="src/main/webapp/img/logo.png" type="image/icon type"/>
    <!-- <script src="src/main/webapp/main.js" ></script> -->
</head>
<body>
<!-- Start Of Header -->
<div class="container header head-boda">
    <div class="row align-items-center">
        <div class="col-md-3">
            <div class="media">
                <a href="/URL-Shortener" class="nav_thing"><img src="src/main/webapp/img/big-logo.png"
                                                                class="nav-img mx-auto d-block"
                /></a>
            </div>
        </div>
        <div class="col-md-6 nav_thing text-center"></div>

        <div class="col-md-3 text-center account-head-dv">
            <%
                if (!login) { %>
            <a href="login" class="account-head">Login</a> &nbsp; &nbsp; | &nbsp;&nbsp;
            <a href="register" class="account-head">Sign Up</a>
            <%
            } else { %>
            <a href="list" class="account-head">My Links</a> &nbsp; &nbsp; | &nbsp;&nbsp;
            <a href="logout" class="account-head"> Logout</a>
            <%
                } %>
        </div>
    </div>
</div>
<!-- End Of Header -->

<!-- Start of main body -->
<div class="container analytics-body">
    <div class="row align-items-center">
        <div class="col-md-2 left-menu">
            <ul class="nav nav-pills flex-column mt-4">
                <li class="nav-item">
                    <a href="list" class="nav-link py-3">My Links</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link py-3 active ">Analytics</a>
                </li>
            </ul>
        </div>
        <div class="col-md-10">
            <div class="charts-body mx-4 p-3">
                <%
                    final String DB_USERNAME = System.getenv("MYSQL_USERNAME");
                    final String DB_PASSWORD = System.getenv("MYSQL_PASSWORD");
                    final String jdbcUrl = "jdbc:mysql://localhost:3306/urlshortener";

                    final String shortened = request.getParameter("shortened");

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    try (Connection connection = DriverManager.getConnection(jdbcUrl, DB_USERNAME, DB_PASSWORD)) {
                        final PreparedStatement selectAnalyticsStmt = connection.prepareStatement("SELECT continent, browser, os, timestamp FROM analytics WHERE shortened_url = ?");
                        selectAnalyticsStmt.setString(1, shortened);

                        final ResultSet rs = selectAnalyticsStmt.executeQuery();
                        HashMap<String, HashMap<String, Integer>> analyticsData = new HashMap<>();
                        ResultSetMetaData metadata = rs.getMetaData();
                        if (!rs.isBeforeFirst() )
                        {
                %>
                            <div class="row text-center">
                                <h1 class="no_views_heading">Nobody has viewed this page yet!!</h1>
                            </div>
                <%
                        }
                        else
                        {
                            while (rs.next()) {
                                for (int i = 1; i <= metadata.getColumnCount(); ++i) {
                                    final String columnName = metadata.getColumnName(i);

                                    final String value = rs.getString(columnName);
                                    int count = analyticsData.getOrDefault(columnName, new HashMap<String, Integer>()).getOrDefault(value, 0) + 1;
                                    if (!analyticsData.containsKey(columnName)) {
                                        analyticsData.put(columnName, new HashMap<String, Integer>());
                                    }
                                    analyticsData.get(columnName).put(value, count);
                                }
                            }
                            request.setAttribute("data", new JSONObject(analyticsData).toString());
                %>
                <div class="row text-center">

                    <div class="col-md-4">
                        <h2 class="chart-header">Continent</h2>
                        <div class="chart-container">
                            <canvas id="continent" style=" width:100%; height: 100%;"></canvas>

                            <script>
                                const analytics = JSON.parse('<%= request.getAttribute("data") %>');
                                console.log(analytics);
                                const continentNames = Object.keys(analytics.continent);
                                const viewsPerContinent = Object.values(analytics.continent);
                                const continentColors = [
                                    "#1144e5",
                                    "#da224f",
                                    "#fff443",
                                    "#d596f5",
                                    "#ff9900",
                                    "#7505ec",
                                    "#05ecd2",
                                ];

                                new Chart("continent", {
                                    type: "pie",
                                    data: {
                                        labels: continentNames,
                                        datasets: [{
                                            label: "continent",
                                            backgroundColor: continentColors,
                                            data: viewsPerContinent
                                        }],
                                    },
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
                                const os = Object.keys(analytics.os);
                                const viewsPerOS = Object.values(analytics.os);
                                const osColors = [
                                    "#3c035d",
                                    "#ff9900",
                                    "#05ec4e",
                                    "#fff443",
                                    "#d596f5",
                                    "#7505ec",
                                    "#da224f",
                                    "#05ecd2",
                                    "#1144e5",
                                    "#7e5536",
                                ];

                                new Chart("os", {
                                    type: "doughnut",
                                    data: {
                                        labels: os,
                                        datasets: [{
                                            backgroundColor: osColors,
                                            data: viewsPerOS
                                        }]
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
                                const browser = Object.keys(analytics.browser);
                                const viewsPerBrowser = Object.values(analytics.browser);
                                const browserColors = [
                                    "#da8422",
                                    "#FF0000",
                                    "#00FF00",
                                    "#0000FF",
                                    "#FFFF00",
                                    "#00FFFF",
                                    "#FF00FF",
                                    "#C0C0C0",
                                    "#FFFFFF",
                                ];

                                new Chart("browser", {
                                    type: "pie",
                                    data: {
                                        labels: browser,
                                        datasets: [{
                                            backgroundColor: browserColors,
                                            data: viewsPerBrowser
                                        }]
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
                                const today = new Date();
                                const todaysDate = today.getDate();

                                const timestamps = new Map();
                                for (let i = todaysDate - 6; i <= todaysDate; ++i) {
                                    timestamps.set(i + "/" + today.getMonth(), 0);
                                }

                                const timestampArr = [];
                                for (const ts in analytics.timestamp) {
                                    for (let i = 0; i < analytics.timestamp[ts]; i++) {
                                        timestampArr.push(ts);
                                    }
                                }

                                for (const timestamp of timestampArr) {
                                    const date = new Date(timestamp + " GMT").getDate();
                                    if (todaysDate - date < 7) {
                                        timestamps.set(date + "/" + today.getMonth(), timestamps.get(date + "/" + today.getMonth()) + 1);
                                    }
                                }
                                const date = Array.from(timestamps.keys());
                                const visitsPerDay = Array.from(timestamps.values());

                                new Chart("visits", {
                                    type: "line",
                                    data: {
                                        labels: date,
                                        datasets: [{
                                            fill: false,
                                            lineTension: 0,
                                            backgroundColor: "rgba(0,0,255,1.0)",
                                            borderColor: "rgba(0,0,255,0.1)",
                                            data: visitsPerDay
                                        }]
                                    },
                                    options: {
                                        legend: {display: false},
                                    }
                                });
                            </script>
                        </div>
                        <h2 class="chart-header">
                            No of visits
                        </h2>

                    </div>
                </div>
                <%
                        }

                    } catch (SQLException e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>


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

            <a href="#" class="foot-lk">About us</a><br/>
            <a href="#" class="foot-lk">Billing Information</a><br/>
            <a href="#" class="foot-lk">Privacy & Policy</a><br/>
            <a href="#" class="foot-lk">Terms & Condition</a><br/>
            <a href="#" class="foot-lk">Data Policies</a><br/>
        </div>

        <div class="col-md-4">
            <div class="foot-t">Socials</div>

            <a href="#" class="foot-lk"
            >Instagram&nbsp;&nbsp;&nbsp;<i class="bi bi-instagram"></i></a
            ><br/>
            <a href="#" class="foot-lk"
            >Twitter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i
                    class="bi bi-twitter"
            ></i></a
            ><br/>
            <a href="#" class="foot-lk"
            >Facebook&nbsp;&nbsp;&nbsp;&nbsp;<i class="bi bi-facebook"></i></a
            ><br/>
            <a href="#" class="foot-lk"
            >Discord&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i
                    class="bi bi-discord"
            ></i></a
            ><br/>
            <a href="#" class="foot-lk"
            >Reddit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i
                    class="bi bi-reddit"
            ></i></a
            ><br/>
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
  