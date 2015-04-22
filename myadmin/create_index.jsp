<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,jmk.*" %>
<%@page errorPage="/error.jsp" %>
<%
    String table = request.getParameter("table");
    
    // get the number of fields or use default 1
    int number = 1;
    try{
        number = Integer.parseInt(request.getParameter("number"));
    }catch(Exception e){}
    Vector vfield = new Vector();
    Vector vtype = new Vector();
    ConDB dbcon = (ConDB)session.getAttribute("dbcon");
    Connection conn = dbcon.get();
    
    // find out all fields of the table for selection
    String sql = "desc " + table;
    PreparedStatement pstm = null;
    ResultSet rs = null;
    try{
        pstm = conn.prepareStatement(sql);
        rs = pstm.executeQuery();
        while (rs.next()){
            vfield.add(rs.getString(1));
            vtype.add(rs.getString(1) + " [" +rs.getString(2) + "]");
        }
    }catch(SQLException e){out.println("SQL Error!");}
%>
<html>
<head><title>JSP Page</title></head>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script src="../js/sql.js"></script>
<!-- import ended -->

<script>
function change_text(){
    if(document.fidx.key.selectedIndex == 0){
        document.fidx.index.disabled = true;
        document.fidx.index.value = "PRIMARY";
    }else{
        document.fidx.index.disabled = false;
        document.fidx.index.value = "";
    }
}
</script>
<body>
<h2>Create index on <b style="color:blue"><%= table %></b></h2>
<hr/>
<form name="fidx" action="run_sql.jsp" method="post">
<table>
    <tr>
        <td>Index name : </td>
        <td><input type="text" name="index" value="" />("PRIMARY" must be the name of and only of a primary key!) </td>
    </tr>
    <tr>
        <td>Index type : </td>
        <td>
          <select size="1" name="key" onchange='change_text()'>
          <option value="PRIMARY">PRIMARY</option>
          <option selected value="INDEX">INDEX</option>
          <option value="UNIQUE">UNIQUE</option>
          </select>
        </td>
    </tr>
</table>
<br/>
<table>
    <tr class="tb_header">
        <td>Field</td>
    </tr>
<%
    // display the field selection
    for(int i=0; i < number; i++){
%>
    <tr class="tb_row_<%= (i & 1) %>">
        <td>
          <select size="1" name="field[]">
          <option value="--ignore--">-- Ignore --</option>
          <% for(int j=0; j < vfield.size(); j++){ %>
          <option value="<%= (String)vfield.get(j) %>"><%= (String)vtype.get(j) %></option>
          <% } %>
          </select>
        </td>
    </tr>
<%
    }
%>
</table>
<br/>
<input type="hidden" name="table" value="<%= table %>"/>
<input type="hidden" name="type" value="create_index"/>
<input type="submit" value="Create"/>
</form>
</body>
</html>
