<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS v5.0.2 -->
    <link rel="stylesheet" href="src/main/webapp/bootstrap/bootstrap.min.css"  >

    <script src="src/main/webapp/bootstrap/bootstrap.bundle.min.js" ></script>

    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <link rel="stylesheet" href="src/main/webapp/style.css" />

    <title>My URLS | Simple URL Shortener</title>

    <link rel="icon" href="src/main/webapp/img/logo.png" type="image/icon type" />
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
            <a href="" class="nav_thing-center">Why Us?</a>
            <a href="" class="nav_thing-center">Custom URL</a>
            <a href="" class="nav_thing-center">Pricing</a>
            <a href="" class="nav_thing-center">Contact Us</a>
        </div>
        <div class="col-md-3 text-center account-head-dv">
            <a href="login" class="account-head">Login</a> &nbsp; &nbsp; | &nbsp;&nbsp;
            <a href="register" class="account-head">Sign Up</a>
        </div>
    </div>
</div>
<!-- End Of Header -->

<!-- Start Of Main Body -->
<div class="container url-list-outa">
    <div class="row align-items-center">
        <div class="col-md-1"></div>
        <div class="col-md-10  my-5">
            <div class="main-title">
                Your Links
            </div>
            <div class="url-list-body px-5 py-3">
            <%
                // declaring variables
                final String DB_USERNAME = System.getenv("MYSQL_USERNAME");
                final String DB_PASSWORD = System.getenv("MYSQL_PASSWORD");
                final String jdbcUrl = "jdbc:mysql://localhost:3306/urlshortener";
                PreparedStatement pstmt;
                ResultSet rs;
                String email_cookie = null;
                Cookie cookie = null;
                Cookie[] cookies = null;
                int j = 1;
                String url = request.getRequestURL().toString();
                url = url.substring(0, url.length() - 4); 
                String delete_url = null;
                String delete_query;
                        
                // Get an array of Cookies associated with the this domain
                cookies = request.getCookies();

                if( cookies != null ) {
                    for (int i = 0; i < cookies.length; i++) {
                        cookie = cookies[i];
                        if (cookie.getName().equals("EMAIL")) {
                            email_cookie = cookie.getValue();
                            email_cookie = email_cookie.replace("%40", "@");
                        }
                    }
                } else {
                    out.println("<h2>No cookies founds</h2>");
                }

                Class.forName("com.mysql.cj.jdbc.Driver");
                try(Connection connection = DriverManager.getConnection(jdbcUrl, DB_USERNAME, DB_PASSWORD)) {
                    if (connection != null) {
                        //checking if userRole is User or not

                        if (request.getMethod().equalsIgnoreCase("post")) { 
                            delete_url = request.getParameter("delete-url");
                            pstmt = connection.prepareStatement("delete from urls where user_email =? and shortened =?");
                            pstmt.setString(1, email_cookie);
                            pstmt.setString(2, delete_url);
                            
                            int rows = pstmt.executeUpdate();

                            if (rows != 0) { %>
                                <script>
                                    Swal.fire({title: "Record deleted successfully.", icon: 'success'});
                                </script>
                            <% }
                        }

                        pstmt = connection.prepareStatement("SELECT * FROM urls WHERE user_email = ?");
                        pstmt.setString(1, email_cookie);

                        rs = pstmt.executeQuery(); 
                        %> 
                        
                        <table class="table list-table">
                            <thead>
                                <tr>
                                <th scope="col" class="table-cell">#</th>
                                <th scope="col" class="table-cell">Original link</th>
                                <th scope="col" class="table-cell">Shortened</th>
                                <th scope="col" class="table-cell">Actions</th>
                                </tr>
                            </thead>

                            <tbody>
                                <!-- start of rows to be looped -->
                                <%
                                while (rs.next()) {%>
                                    <tr>
                                        <th scope="row" class="table-cell"><%= j%></th>
                                        <td class="table-cell" title="<%= rs.getString("original")%>" onclick="copy_to_clipboard(this)"><%= rs.getString("original")%></td>
                                        <td class="table-cell shortened-cell" id="shortened-<%= j %>" title="<%= url + "s/" + rs.getString("shortened")%>" onclick="copy_to_clipboard(this)"><%= url + "s/" + rs.getString("shortened")%></td>
                                        <td class="table-cell px-0 actions actions-cell">
                                            <button class="btn list-btn"><i class="bi bi-files" onclick="copy_to_clipboard(document.getElementById('shortened-<%= j %>'))" ></i></button>
                                            <form action="shorten" method="post" style="display: inline;">
                                                <input type="hidden" name="delete-url" value="<%=rs.getString("shortened")%>">
                                                <button type="submit" class="btn list-btn"><i class="bi bi-pencil-square"></i></button>
                                            </form>
                                            <form action="list" method="post" style="display: inline;">
                                                <input type="hidden" name="delete-url" value="<%=rs.getString("shortened")%>">
                                                <button type="submit" class="btn list-btn"><i class="bi bi-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr><%
                                    j++;
                                }
                                %>
                                <!-- end of rows to be looped -->
                            </tbody>
                            </table>
                    <%  
                    }
                    connection.close();
                } catch (SQLException e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
            </div>
        </div>
        <div class="col-md-2"></div>
    </div>
</div>
<!-- End Of Main Body -->

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
                We are fiercely committed to our customers success. Our job is to
                ensure that our trusted platform, performance, and people help
                customers achieve their goals.
            </div>
        </div>
    </div>
</div>

<script>
   function copy_to_clipboard(element) {
        const text = element.innerText;
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
