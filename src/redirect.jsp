<%@ page import="java.util.zip.CRC32" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>

<%

final String[] urlParts = request.getRequestURI().split("/");
final String shortened = urlParts[urlParts.length - 1];

// declaring variables
final String DB_USERNAME = System.getenv("MYSQL_USERNAME");
final String DB_PASSWORD = System.getenv("MYSQL_PASSWORD");
final String jdbcUrl = "jdbc:mysql://localhost:3306/urlshortener";

Class.forName("com.mysql.cj.jdbc.Driver");
try (Connection connection = DriverManager.getConnection(jdbcUrl, DB_USERNAME, DB_PASSWORD)) {
    if (connection != null) {
        //checking if userRole is User or not
        final PreparedStatement pstmt = connection.prepareStatement("SELECT original FROM urls WHERE shortened = ?");
        pstmt.setString(1, shortened);

        final ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            if (request.getParameter("analytics") == null) {
            %>
<html>
<head>
<script src="/URL-Shortener/src/main/webapp/js/platform.js"> </script>
<script>
function trackIP() {
    const options = {
        method: 'GET',
        headers: {
            'X-RapidAPI-Host': 'ip-geolocation-ipwhois-io.p.rapidapi.com',
            'X-RapidAPI-Key': '<%= System.getenv("RAPID_API_KEY") %>'
        }
    };

    return fetch('https://api.ipify.org/')
        .then(ipAddressResponse => ipAddressResponse.text())
        .then(ipAddress => (
            fetch("https://ip-geolocation-ipwhois-io.p.rapidapi.com/json/?ip=" + ipAddress, options)
                .then(response => response.json())
                .then(response => response)
                .catch(err => console.error(err))
        ))
        .catch(err => console.error(err));
}

function getAnalytics() {
    trackIP().then(data => {
        const analytics = {};
        analytics.continent = data.continent;
        analytics.country = data.country;
        analytics.browser = platform.name;
        analytics.os = platform.os.family;
        analytics.ip = data.ip;

        document.getElementById("analytics").value = JSON.stringify(analytics);
        document.querySelector("form").submit();
    });
}

</script>
<head>
<body onload="getAnalytics()">
<form action="<%= request.getRequestURI() %>" method="post">
<input type="hidden" id="analytics" name="analytics" />
</form>
</body>
</html>

            <%
            } else {
                JSONObject nodeRoot  = new JSONObject(request.getParameter("analytics"));
                final PreparedStatement analyticsPstmt = connection.prepareStatement("INSERT INTO analytics(shortened_url, ip, continent, country, browser, os) VALUES(?, ?, ?, ?, ?, ?);");
                analyticsPstmt.setString(1, shortened);
                analyticsPstmt.setString(2, nodeRoot.getString("ip"));
                analyticsPstmt.setString(3, nodeRoot.getString("continent"));
                analyticsPstmt.setString(4, nodeRoot.getString("country"));
                analyticsPstmt.setString(5, nodeRoot.getString("browser"));
                analyticsPstmt.setString(6, nodeRoot.getString("os"));
                analyticsPstmt.executeUpdate();

                response.sendRedirect(rs.getString("original"));
            }
        } else {
            response.sendError(404, "The shortened URL doesn't exist");
        }
    }
    connection.close();
} catch (SQLException e) {
    out.println("Error: " + e.getMessage());
}
%>
