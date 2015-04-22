<%@page errorPage="/error.jsp" %>
<%
    // just destroy the session, and go back to the login page
    String db = (String)session.getAttribute("db");
    String user = (String)session.getAttribute("user");
    String ip = (String)request.getRemoteAddr();
    session.invalidate();
    // logging
    System.out.println("==== Logout ====");
    System.out.println("Date  : " + new java.util.Date() );
    System.out.println("IP    : " + ip);
    System.out.println("DB    : " + db);
    System.out.println("User  : " +  user);
%>
<script>
parent.location = "../index.jsp";
</script>
