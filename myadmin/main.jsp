<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*,jmk.*" %>
<%@page errorPage="/error.jsp" %>
<%@page errorPage="/error.jsp" %>
<html>
<head><title>Home</title></head>
<body>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script src="../js/sql.js"></script>
<!-- import ended -->

<h2>User <b style="color:blue"><%= (String)session.getAttribute("user") %></b> connecting on <b style="color:blue"><%= (String)session.getAttribute("db") %></b></h2>
<hr/>
<table border=0>
    <tr class="tb_header">
        <td>Table</td>
        <td>Action</td>
        <td>Records</td>
    </tr>
<%

// get all tables in the database
ConDB dbcon = (ConDB)session.getAttribute("dbcon");
Connection conn = dbcon.get();
int total_rec = 0;
int total_table = 0;
String sql = "show tables";
PreparedStatement pstm =null;
ResultSet rs =null;
try{
    pstm = conn.prepareStatement(sql);
    rs = pstm.executeQuery();
}catch(SQLException e){out.println(e);}

// count the records of each table
while (rs.next()){
    String curr_tb = rs.getString(1);
    int curr_rec = 0;
    PreparedStatement pstm_rec = null;
    ResultSet rs_rec = null;
    sql = "select count(*) from " + curr_tb;
    
    try{
        pstm_rec = conn.prepareStatement(sql);
        rs_rec = pstm_rec.executeQuery();
    }catch(SQLException e){out.println(e);}
    
    try{
        if(rs_rec.next()){
            curr_rec = rs_rec.getInt(1);
            total_rec += curr_rec;
        }
    }catch(SQLException e){
        out.println(e.getErrorCode() + "---" + e.getSQLState());
    }
    
    total_table++;
    
%>
    <tr class="tb_row_<%= total_table & 1 %>">
        <td><%= curr_tb %></td>
        <td>
            <table>
                <tr>
                    <td><a href='javascript:browse("<%= curr_tb %>")'><img border=0 width=18 height=18 src="../images/button_browse.png" alt="Browse"></a></td>
                    <td><a href='javascript:proper("<%= curr_tb %>")'><img border=0  width=18 height=18 src="../images/button_properties.png" alt="Properties"></a></td>
                    <td><a href='javascript:drop_tb("<%= curr_tb %>")'><img border=0  width=18 height=18 src="../images/button_drop.png" alt="Drop"></a></td>
                    <td><a href='javascript:empty_tb("<%= curr_tb %>")'><img border=0  width=18 height=18 src="../images/button_empty.png" alt="Empty"></a></td>                    
                </tr>
            </table>
        </td>
        <td><%= curr_rec %></td>
    </tr>
<%

}
%>
    <tr class="tb_header">
        <td><%= total_table %> table(s)</td>
        <td>Sum</td>
        <td><%= total_rec %></td>
    </tr>
</table>

<hr/>

<form action="create_table.jsp" method="post">
<table>
    <tr>
 Create table on database <%= session.getAttribute("db") %> :
    </tr>
    <tr>
        <td>Table Name : </td>
        <td><input type="text" name="table"/></td>
    </tr>
    <tr>
        <td>Fields : </td>
        <td>
            <input type="text" name="number" size="5"/>
            <input type="submit" value="Create">
        </td>
    </tr>
</table>
</form>
</body>
</html>
