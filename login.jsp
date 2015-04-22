<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page errorPage="/error.jsp" %>
<%
    String ip = request.getRemoteAddr();
    String admin = "disabled";
    if (ip.equals("127.0.0.1")){
        admin = "";
    }
%>
<html>
<head><title>jspMyAdmin Login</title></head>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="./css/mystyle.css" />
<script src="./js/sql.js"></script>
<!-- import ended -->
<body>
<h2 align="center">jspMyAdmin</h2>
<hr/>
<form method="post" action="auth.jsp">
<table align="center">
    <tr>
        <td>Host : </td>
        <td><input type="text" name="host" value="localhost" size="20" /><b>:</b><input type="text" name="port" value="3306" size="5" /></td>
    </tr>
    <tr>
        <td>Database : </td>
        <td> <input type="text" name="database" size="30" /></td>
    </tr>
    <tr>
        <td>User : </td>
        <td><input type="text" name="user" size="30" /></td>
    </tr>
    <tr>
        <td>Password : </td>
        <td><input type="password" name="password" size="30" /></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <div align="left">
                <input type="submit" value="User Login">
                <input type="button" <%= admin %> value="System Admin" onclick="sys_admin()">
            </div>
        </td>
    </tr>
</table>

</form>

</body>
</html>
