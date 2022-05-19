<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.*" %>
<%
    boolean isLinkInUse = false;
    boolean isLinkSame = false;
    String errorMessage = "";
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
%>
<%
    if (!(request.getParameterMap().containsKey("shortenedURL") && request.getParameterMap().containsKey("originalURL"))) {
        response.sendRedirect("/URL-Shortener");
    }
    if (request.getParameterMap().containsKey("editedShortenedURL")) {
        final String DB_USERNAME = System.getenv("MYSQL_USERNAME");
        final String DB_PASSWORD = System.getenv("MYSQL_PASSWORD");
        final String jdbcUrl = "jdbc:mysql://localhost:3306/urlshortener";
        String shortenedURL = request.getParameter("shortenedURL");
        String editedShortenedURL = request.getParameter("editedShortenedURL");

        if (shortenedURL.equals(editedShortenedURL)) {
            isLinkSame = true;
            errorMessage = "Please change the URL in order to edit!!";
        } else {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(jdbcUrl, DB_USERNAME, DB_PASSWORD)) {
                final PreparedStatement checkIfExists = connection.prepareStatement("SELECT * FROM urls WHERE shortened = ?");
                checkIfExists.setString(1, editedShortenedURL);
                final ResultSet rs = checkIfExists.executeQuery();
                if (!rs.isBeforeFirst()) {
                    ZonedDateTime zdt = ZonedDateTime.of(LocalDateTime.now(), ZoneId.systemDefault());
                    ZonedDateTime gmt = zdt.withZoneSameInstant(ZoneId.of("GMT"));

                    final PreparedStatement updateURLStmt = connection.prepareCall("CALL update_shortened_url(?, ?, ?)");
                    updateURLStmt.setString(1, shortenedURL);
                    updateURLStmt.setString(2, editedShortenedURL);
                    updateURLStmt.setTimestamp(3, Timestamp.valueOf(gmt.toLocalDateTime()));
                    updateURLStmt.executeUpdate();

                    response.sendRedirect("list");
                } else {
                    isLinkInUse = true;
                    errorMessage = "The link you have selected is already in use!!";
                }
            } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
            }


        }
    }

%>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />

    <!-- Bootstrap CSS v5.0.2 -->
    <link rel="stylesheet" href="src/main/webapp/bootstrap/bootstrap.min.css">

    <script src="src/main/webapp/bootstrap/bootstrap.bundle.min.js"></script>

    <link rel="stylesheet" href="src/main/webapp/style.css"/>

    <title>Simple URL Shortener</title>

    <link rel="icon" href="src/main/webapp/img/logo.png" type="image/icon type"/>
    <%--      <script src="src/main/webapp/main.js" ></script>--%>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<!-- Start Of Header -->
<div class="container header">
    <div class="row align-items-center">
        <div class="col-md-3">
            <div class="media">
                <a href="/URL-Shortener/" class="nav_thing"
                ><img src="src/main/webapp/img/big-logo.png" class="nav-img mx-auto d-block"
                /></a>
            </div>
        </div>
        <div class="col-md-6 nav_thing text-center">

        </div>
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
<div class="container">
    <div class="row align-items-center shorten-body">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <h2 class="main-title">Original link</h2>
            <div class="og-link mb-5"><%= request.getParameter("originalURL") %>
            </div>

            <div class="mb-3">
                <h2 class="main-title">Shortened Link</h2>
                <form action="shorten" method="post">
                    <div class="input-group new-div">
                      <span class="form-control new-link text-center">
                          <span class="my-3 d-block new-link-title"
                                id="new-link-title"><%= request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/s/" %></span>
                      
                      </span>
                        <input class="form-control" type="text" id="editbox" name="editedShortenedURL"
                               value='<%= request.getParameter("shortenedURL") %>' required/>
                        <button class="btn px-2 edit-btn" type="button" title="copy"
                                onclick='copy_to_clipboard("<%= request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/s/" %>","editbox")'>
                            <i class="bi bi-files"></i>
                        </button>

                        <input type="hidden" name="originalURL" value="<%= request.getParameter("originalURL") %>">
                        <input type="hidden" name="shortenedURL" value="<%= request.getParameter("shortenedURL") %>">

                        <div class="input-group-append">
                            <button class="btn px-3" id="save-btn" type="submit" title="save">
                                <i class="bi bi-pencil-fill"></i>
                            </button>
                        </div>
                    </div>
                </form>
                <%

                    if (isLinkInUse || isLinkSame) {
                %>
                <div class="alert alert-warning my-3" role="alert">
                    <%
                        out.println(errorMessage);
                    %>
                </div>

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

<script>
    function copy_to_clipboard(prefix, eleid) {
        const copyText = document.getElementById(eleid);
        const text = prefix + copyText.value;
        /* Copy the text inside the text field */
        navigator.clipboard.writeText(text);
        Swal.fire({
            title: 'Copied to clipboard!',
            text,
            icon: 'success',
        });
    }
</script>
<!-- End of Footer -->
</body>
</html>
