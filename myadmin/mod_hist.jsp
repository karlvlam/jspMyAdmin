<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,jmk.*" %>
<%@page errorPage="/error.jsp" %>
<%
    int hist_rec = 0;
    String sql = "";
    Vector history = (Vector)session.getAttribute("sqlHistory");
    try{
        hist_rec = Integer.parseInt(request.getParameter("hist_rec"));
        sql = (String)history.get(hist_rec);
    }catch(Exception e){
        sql = "";
    }
%>
<html>
<head><title>JSP Page</title></head>
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script src="../js/sql.js"></script>
<!-- import ended -->
<body>
<h2>Modify History</h2>
<hr/>
<form action="run_sql.jsp" method="post">
<textarea name="sql" rows="20" cols="80"><%= sql %></textarea>
    <br/>
    <!-- hidden values, don't miss them -->
    <input type="hidden" name="type" value="run"/>
    <input type="submit" value="Run"/>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <input type="reset" value="Reset"/>
</form>
</body>
</html>
