<%@ page import="java.util.zip.CRC32" %>
<%@ page import="java.sql.*" %>

<%
final String[] urlParts = request.getRequestURI().split("/");
final String shortened = urlParts[urlParts.length - 1];

// declaring variables
final String DB_USERNAME = System.getenv("MYSQL_USERNAME");
final String DB_PASSWORD = System.getenv("MYSQL_PASSWORD");
final String jdbcUrl = "jdbc:mysql://localhost:3306/urlshortener";

Class.forName("com.mysql.cj.jdbc.Driver");
try(Connection connection = DriverManager.getConnection(jdbcUrl, DB_USERNAME, DB_PASSWORD)) {
    if (connection != null) {
        //checking if userRole is User or not
        final PreparedStatement pstmt = connection.prepareStatement("SELECT original FROM urls WHERE shortened = ?");
        pstmt.setString(1, shortened);

        final ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            response.sendRedirect(rs.getString("original"));
        } else {
            response.sendError(404, "The shortened URL doesn't exist");
        }
    }
    connection.close();
} catch (SQLException e) {
    out.println("Error: " + e.getMessage());
}
%>
