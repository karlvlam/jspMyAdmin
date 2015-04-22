<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,jmk.*" %>
<%@page errorPage="/error.jsp" %>
<%
String table = request.getParameter("table");
%>
<html>
<head><title>Show Table</title></head>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script src="../js/sql.js"></script>
<!-- import ended -->


<body>
<h2>Table <b style="color:blue"><%= table%></b></h2>
<hr/>
<table border="0" width="100%">
    <tr>
        <td width="25%" align="center"><a href='javascript:proper("<%= table %>")'>Structure</a></td>
        <td width="25%" align="center"><a href='javascript:browse("<%= table %>")'>Browse</a></td>
        <td width="25%" align="center"><a href='javascript:empty_tb("<%= table %>")'>Empty</a></td>
        <td width="25%" align="center"><a href='javascript:drop_tb("<%= table %>")'>Drop</a></td>
    </tr>
</table>
<hr/>
<table border="0" align="center">
    <tr>Structure table :</tr>
    <tr class="tb_header">
        <td>Field</td>
        <td>Type</td>
        <td>Null</td>
        <td>Key</td>
        <td>Default</td>
        <td>Extra</td>
        <td>Action</td>
    </tr>
<%

int recCount = 0;
Vector vField = new Vector();

ConDB dbcon = (ConDB)session.getAttribute("dbcon");
Connection conn = dbcon.get();
String sql = "desc " + table;
PreparedStatement pstm = null;
ResultSet rs = null;
// show table structure
try{
    pstm = conn.prepareStatement(sql);
    rs = pstm.executeQuery();

    while(rs.next()){

        String Field = rs.getString(1);
        vField.add(Field);
        String Type = rs.getString(2);
        String Null = rs.getString(3);
        String Key = rs.getString(4);
        String Default = rs.getString(5);
        String Extra = rs.getString(6);
        recCount++;
%>
    <tr class="tb_row_<%= recCount & 1 %>">
        <td><%= Field %>&nbsp;</td>
        <td><%= Type %>&nbsp;</td>
        <td><%= Null %>&nbsp;</td>
        <td><%= Key %>&nbsp;</td>
        <td><%= Default %>&nbsp;</td>
        <td><%= Extra %>&nbsp;</td>
        <td>
            <table>
                <tr>
                    <td><a href='javascript:mod_fd("<%= table %>", "<%= Field %>")' title="Modify"><img border=0  width=18 height=18 src="../images/button_edit.png" /></a></td>
                    <td><a href='javascript:drop_fd("<%= table %>", "<%= Field %>")' title="Drop"><img border=0  width=18 height=18 src="../images/button_drop.png" /></a></td>
                    <td><a href='javascript:new_pk("<%= table %>", "<%= Field %>")' title="Primary"><img border=0  width=18 height=18 src="../images/button_primary.png" /></a></td>
                    <td><a href='javascript:new_idx("<%= table %>", "<%= Field %>")' title="Index"><img border=0  width=18 height=18 src="../images/button_index.png" /></a></td>                    
                    <td><a href='javascript:new_uni("<%= table %>", "<%= Field %>")' title="Unique"><img border=0  width=18 height=18 src="../images/button_unique.png" /></a></td>   
                </tr>
            </table>
        </td>
    </tr>

<%
    }
}catch(SQLException e){out.println("SQL Error!");}
%>
</table>
<br/>
<!-- Index Table -->
<%
    sql = "show index from " + table;
    MyConstraint mc = new MyConstraint();
    try{
        pstm = conn.prepareStatement(sql);
        rs = pstm.executeQuery();
        
        while (rs.next()){        
            // put the data to MyConstraint, which can read the index type
            mc.add(rs.getString(2).charAt(0),rs.getString(3),rs.getString(5));
        }
    }catch(SQLException e){ out.println("SQL Error!");}
    Vector pk = mc.getPk();
    Vector uk = mc.getUk();
    Vector idx = mc.getIdx();
    
    if(mc.size() > 0){
        int styleCount = 0;
%>
<table>
    <tr>Index table :</tr>
    <tr class="tb_header">
        <td>Keyname</td>
        <td>Type</td>
        <td>Action</td>
        <td>Field</td>
    </tr>
<%
        // Primary key start
        if(pk.size() > 0){
%>
    <tr class="tb_row_<%= (styleCount & 1) %>">
        <td>PRIMARY</td>
        <td>PRIMARY</td>
        <td>
            <a href='javascript:drop_key("<%= table %>","PRIMARY")'>
                <img border=0 width=18 height=18 src="../images/button_drop.png">
            </a>
        </td>
        <td>
            <table>
<%
    for(int i=0; i < pk.size(); i++){
        out.println("<tr><td>"+pk.get(i).toString()+"</td></tr>");
    }
%>
            </table>
        </td>
    </tr>
<%
        styleCount++;
        // Primary key end
        }
%>

<%
        // Unique start
        for(int i=0; i < uk.size(); i++, styleCount++){
            MyIndex mi = (MyIndex)uk.get(i);
            Vector ukField = mi.getField();
%>
    <tr class="tb_row_<%= (styleCount & 1) %>">
        <td><%= mi.getKeyName() %></td>
        <td>UNIQUE</td>
        <td>
            <a href='javascript:drop_key("<%= table %>","<%= mi.getKeyName() %>")'>
                <img border=0 width=18 height=18 src="../images/button_drop.png">
            </a>
        </td>
        <td>
            <table>
<%
    for(int j=0; j < ukField.size(); j++){
        out.println("<tr><td>"+ukField.get(j).toString()+"</td></tr>");
    }
%>
            </table>
        </td>
    </tr>
<%
        // Unique end
        }
%>

<%
        // Index start
        for(int i=0; i < idx.size(); i++, styleCount++){
            MyIndex mi = (MyIndex)idx.get(i);
            Vector idxField = mi.getField();
%>
    <tr class="tb_row_<%= (styleCount & 1) %>">
        <td><%= mi.getKeyName() %></td>
        <td>INDEX</td>
        <td>
            <a href='javascript:drop_key("<%= table %>","<%= mi.getKeyName() %>")'>
                <img border=0 width=18 height=18 src="../images/button_drop.png">
            </a>
        </td>
        <td>
            <table>
<%
    for(int j=0; j < idxField.size(); j++){
        out.println("<tr><td>"+idxField.get(j).toString()+"</td></tr>");
    }
%>
            </table>
        </td>
    </tr>
<%
        // Index end
        }
%>
</table>
<%
    }
%>

<hr/>
<form action="add_field.jsp" method="post">
<input type="hidden" name="table" value="<%= table %>"/>
    <table>
        <tr>
            <td>Add new field : </td>
    
            <td><input type="text" name="number" value="1" size="5" /></td>

            <td>
                <select size="1" name="after">
                    <option selected value="--end--">At End of Table</option>
                    <option value="--first--">At Beginning of Table</option>
<%
    for(int i=0; i<vField.size(); i++){
        String fd = (String)vField.get(i);
%>
                    <option value="<%= fd %>">After <%= fd %></option>
<%
    }
%>
                </select>
            </td>
            <td><input type="submit" value="Go"</td>
        </tr>
   </table>
</form>
<form action="create_index.jsp" method="post">
        <input type="hidden" name="table" value="<%= table %>"/>
        Create an index on <input type="text" name="number" value="1" size="5"/> columns <input type="submit" value="Go"/>
</form>
</body>
</html>

