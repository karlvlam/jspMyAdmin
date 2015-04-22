<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*,jmk.*" %>
<%@page errorPage="/error.jsp" %>
<html>
<head><title>Add Field</title></head>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script src="../js/sql.js"></script>
<!-- import ended -->
<body>
<%
String table = request.getParameter("table");
String after = request.getParameter("after");

// get the number of fields or use default 
int number = 1;
try{
number = Integer.parseInt(request.getParameter("number"));
}catch(NumberFormatException nfe){}

if (table != null && after != null){

%>
<h2>Add Fields to <b style="color:blue"><%= table %></b></h2>
<hr/>
<form action="run_sql.jsp" method="post">
<table border="1">
  <tr>
    <td >Field Name</td>
    <td >Type</td>
    <td >Length</td>
    <td >Null</td>
    <td >Default</td>
    <td >Extra</td>
  </tr>
 <%
 // display fields, options for selection
 for (int i=0; i < number; i++){
%>
  <tr>
    <td ><input type="text" name="field[]" size="16"></td>
    <td ><select size="1" name="data_type[]">
    <option selected value="VARCHAR">VARCHAR</option>
    <option value="TEXT">TEXT</option>
    <option value="DATE">DATE</option>
    <option value="SMALLINT">SMALLINT</option>
    <option value="MEDIUMINT">MEDIUMINT</option>
    <option value="INT">INT</option>
    <option value="BIGINT">BIGINT</option>
    <option value="DOUBLE">DOUBLE</option>
    <option value="DECIMAL">DECIMAL</option>
    <option value="DATETIME">DATETIME</option>
    <option value="TIMESTAMP">TIMESTAMP</option>
    <option value="TIME">TIME</option>
    <option value="YEAR">YEAR</option>
    <option value="CHAR">CHAR</option>
    <option value="TINYBLOB">TINYBLOB</option>
    <option value="TINYTEXT">TINYTEXT</option>
    <option value="BLOB">BLOB</option>
    <option value="MEDIUMBLOB">MEDIUMBLOB</option>
    <option value="MEDIUMTEXT">MEDIUMTEXT</option>
    <option value="LONGBOLB">LONGBOLB</option>
    <option value="LONGTEXT">LONGTEXT</option>
    <option value="ENUM">ENUM</option>
    <option value="SET">SET</option>
    <option value="FLOAT">FLOAT</option>
    <option value="TINYINT">TINYINT</option>
    </select></td>
    <td ><input type="text" name="data_length[]" size="5"></td>
    <td ><select size="1" name="null_value[]">
    <option selected value="NOT NULL">not null</option>
    <option value="NULL">null</option>
    </select></td>
    <td ><input type="text" name="default_value[]" size="10"></td>
    
    <td ><select size="1" name="extra[]">
    <option selected value=""></option>
    <option value="AUTO_INCREMENT">AUTO_INCREMENT</option>
    </select>
  </tr>
<%
}
%>
</table>

<br/><br/>
<!-- hidden fields, don't miss them-->
<input type="hidden" name="type" value="add_field" />
<input type="hidden" name="after" value="<%= after %>" />
<input type="hidden" name="table" value="<%= table %>" />
<input type="hidden" name="field_number" value="<%= number %>" />
<input type="submit" value="Add Fields" />
</form>

<table border="0" width="100%">
<tr><td>
*  If field type is "enum" or "set", please enter the values using this format: 'a','b','c'...
</td></tr>
<tr><td>
If you ever need to put a backslash ("\") or a single quote ("'") amongst those values, backslashes it (for example '\\xyz' or 'a\'b').  
</td></tr>
<tr><td>
**  For default values, please enter just a single value, without backslash escaping or quotes, using this format: a  
</td></tr>
</table>

<%
}else{
    out.println("Error!");
}
%>
</body>
</html>
