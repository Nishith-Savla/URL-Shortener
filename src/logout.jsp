<%
    Cookie cookie = null;
    Cookie[] cookies = null;
    cookies = request.getCookies();
    if( cookies != null )
    {
        for (int i = 0; i < cookies.length; i++) {
            cookie = cookies[i];
            if (cookie.getName().equals("EMAIL") && cookie.getValue() != "") {
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
                break;
            }
        }
    }
    response.sendRedirect("login");
%>