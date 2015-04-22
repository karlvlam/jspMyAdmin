<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page errorPage="/error.jsp" %>
<html>
<head><title>SQL Command</title></head>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script src="../js/sql.js"></script>
<!-- import ended -->
<body>
<h2>SQL Command</h2>
<hr/>
<form action="run_sql.jsp" method="post">
<textarea name="sql" rows="20" cols="80"></textarea>
<br/>
<!-- hidden values, don't miss them -->
<input type="hidden" name="type" value="run"/>
<input type="submit" value="Run"/>
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="reset" value="Clear"/>
</form>
</body>
</html>
