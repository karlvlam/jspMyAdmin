<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,jmk.*" %>
<%@page errorPage="/error.jsp" %>
<html>
<head><title>JSP Page</title></head>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script src="../js/sql.js"></script>
<!-- import ended -->
<body>
<base target="_self">

<%
//get all tables from database
ConDB dbcon = (ConDB)session.getAttribute("dbcon");
Connection conn = dbcon.get();
Vector vTable = new Vector();
Vector vRec = new Vector();
String sql = "show tables";
int total_table = 0;
PreparedStatement pstm = null;
ResultSet rs = null;
try{
    pstm = conn.prepareStatement(sql);
    rs = pstm.executeQuery();
    while(rs.next()){
        vTable.add(rs.getString(1));
        total_table++;
    }
}catch(SQLException e){ out.println("SQL Error!");}

// count the records of eahc tables
for (int i = 0; i < vTable.size(); i++){
    sql = "select count(*) from " + (String)vTable.get(i);
    try{
        pstm = conn.prepareStatement(sql);
        rs = pstm.executeQuery();
        while(rs.next()){
            vRec.add(rs.getString(1));
        }
    }catch(SQLException e){ out.println("SQL Error!");}
}
%>
Database <b style=''color:green"><%= session.getAttribute("db") %> (<%= total_table %>)</b><br/>
<a href="menu.jsp">Refresh</a><br/> 
<a href="main.jsp" target="main">Home</a> <br/>
<hr/>
<table cellpadding=0 celspacing=0 style="border-collapse: collapse">
<%

for (int i = 0; i < vTable.size(); i++){
    String tname = (String)vTable.get(i);
    String rowNum = " (" + (String)vRec.get(i) + " rows)";
%>
    <tr>
        <td>
            <a href='javascript:browse("<%= tname %>")'>
            <img border=0 src="../images/button_browse.png" alt="Browse">
            </a>
        </td>
        <td>
            <a href='javascript:proper("<%= tname %>")' title="Properties" target="_self"><%= tname %></a>
        </td>
        <td>
            <%= rowNum %>
        </td>
    <tr/>
<%
}
%>
</table>
<hr/>
<a href="create_table.jsp" target="main">Create Table</a> <br/>
<a href="sql.jsp" target="main">SQL</a> <br/>
<a href="history.jsp" target="main">History</a> <br/>
<hr/>
<a href="javascript:logout()" target="_self">Logout</a> <br/>

</body>
</html>
