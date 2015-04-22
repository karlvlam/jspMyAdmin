<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,jmk.*" %>
<%@page errorPage="/error.jsp" %>
<%
// get the history vector from session
Vector history = (Vector)session.getAttribute("sqlHistory");
String type = request.getParameter("type");

if (type != null){
    int hist_rec = -1;
    try{
        hist_rec = Integer.parseInt((String)request.getParameter("hist_rec"));
    }catch(Exception e){}
    if (type.equals("remove")){
        // clear all history
        if (hist_rec < 0){
            history.clear();
        }else{
        // only remove one history record
            history.remove(hist_rec);
        }
    }
}
%>
<html>
<head><title>SQL History</title></head>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script src="../js/sql.js"></script>
<!-- import ended -->
<body>
<h2>SQL History</h2>
<hr/>
<%
if (history.size() < 1) out.println("No SQL history.");
%>
<table border='0'>
<%
// show history, descending
for(int i=history.size() -1; i >= 0;i--){
    out.println("<tr class='tb_row_"+(i & 1)+"'>");
    
    out.println("<td>" + i + "</td>");
    out.println("<td><a href='javascript:hist_run("+i+")' title='Execute'><img border=0 src='../images/button_run.png' /></a></td>");
    out.println("<td><a href='javascript:hist_remove("+i+")' title='Remove'><img border=0 src='../images/button_drop.png' /></a></td>");
    out.println("<td><pre>" + history.get(i).toString() + "</pre></td>");
    out.println("</tr>");
}
%>
</table>

<hr/>
<input type='button' value='Clear All History' onclick='hist_clear()''/>
</body>
</html>
