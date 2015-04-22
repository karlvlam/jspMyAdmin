<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,jmk.*" %>
<%@page errorPage="/error.jsp" %>
<html>
<head><title>Create Table</title></head>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script src="../js/sql.js"></script>
<!-- import ended -->
<body>
<%
String table = request.getParameter("table");
String field = request.getParameter("field");

if (table != null && field != null){
    
    String fname = "";
    String ftype = "";
    String fsize = "";
    String fdefault = "";
    
    // Hashing for the pull down menus
    Map typeSel = new HashMap();
    typeSel.put("VARCHAR", "");
    typeSel.put("TEXT", "");
    typeSel.put("DATE", "");
    typeSel.put("SMALLINT", "");
    typeSel.put("MEDIUMINT", "");
    typeSel.put("INT", "");
    typeSel.put("BIGINT", "");
    typeSel.put("DOUBLE", "");
    typeSel.put("DECIMAL", "");
    typeSel.put("DATETIME", "");
    typeSel.put("TIMESTAMP", "");
    typeSel.put("TIME", "");
    typeSel.put("YEAR", "");
    typeSel.put("CHAR", "");
    typeSel.put("TINYBLOB", "");
    typeSel.put("TINYTEXT", "");
    typeSel.put("BLOB", "");
    typeSel.put("MEDIUMBLOB", "");
    typeSel.put("MEDIUMTEXT", "");
    typeSel.put("LONGBOLB", "");
    typeSel.put("LONGTEXT", "");
    typeSel.put("ENUM", "");
    typeSel.put("SET", "");
    typeSel.put("FLOAT", "");
    typeSel.put("TINYINT", "");

    // get DB connection
    ConDB dbcon = (ConDB)session.getAttribute("dbcon");
    Connection conn = dbcon.get();
    String sql = "desc `" +table+ "`";
    PreparedStatement pstm = null;
    ResultSet rs = null;
    try{
        pstm = conn.prepareStatement(sql);
        rs = pstm.executeQuery();
        // get the field name, data type, length, default ...
        while (rs.next()){
            if(rs.getString(1).equals(field)){
                fname = rs.getString(1);
                fdefault = rs.getString(5);
                String temp = rs.getString(2).toUpperCase();
                if (temp.indexOf("(") < 0){
                    ftype = temp;
                }else{
                    ftype = temp.substring(0, temp.indexOf("("));
                    fsize = temp.substring(temp.indexOf("(")+1, temp.indexOf(")"));
                }
                // HASH the null value
                if (rs.getString(3).equals("YES")){
                    typeSel.put("NULL", "selected");
                    typeSel.put("NOT NULL", "");
                }else{
                    typeSel.put("NULL", "");
                    typeSel.put("NOT NULL", "selected");
                }
                if (rs.getString(6).equals("auto_increment")){
                    typeSel.put("AUTO_INCREMENT", "selected");
                    typeSel.put("NO_ATI", "");
                }else{
                    typeSel.put("AUTO_INCREMENT", "");
                    typeSel.put("NO_ATI", "selected");
                }

                // reHASH the field type
                typeSel.remove(ftype);
                typeSel.put(ftype, "selected");
                break;
            }
        }
    }catch(SQLException e){out.println(e);}
%>

<h2>Modify Field <b style="color:blue"><%= field %></b> in <b style="color:blue"><%= table %></b></h2>
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

  <!-- use the HASH function to put the "SELECTED" key word to the options -->
  <tr>
    <td ><input type="text" name="field_name" size="16" value="<%= fname %>"></td>
    <td ><select size="1" name="data_type">
    <option <%= (String)typeSel.get("VARCHAR") %> value="VARCHAR">VARCHAR</option>
    <option <%= (String)typeSel.get("TEXT") %> value="TEXT">TEXT</option>
    <option <%= (String)typeSel.get("DATE") %> value="DATE">DATE</option>
    <option <%= (String)typeSel.get("SMALLINT") %> value="SMALLINT">SMALLINT</option>
    <option <%= (String)typeSel.get("MEDIUMINT") %> value="MEDIUMINT">MEDIUMINT</option>
    <option <%= (String)typeSel.get("INT") %> value="INT">INT</option>
    <option <%= (String)typeSel.get("BIGINT") %> value="BIGINT">BIGINT</option>
    <option <%= (String)typeSel.get("DOUBLE") %> value="DOUBLE">DOUBLE</option>
    <option <%= (String)typeSel.get("DECIMAL") %> value="DECIMAL">DECIMAL</option>
    <option <%= (String)typeSel.get("DATETIME") %> value="DATETIME">DATETIME</option>
    <option <%= (String)typeSel.get("TIMESTAMP") %> value="TIMESTAMP">TIMESTAMP</option>
    <option <%= (String)typeSel.get("TIME") %> value="TIME">TIME</option>
    <option <%= (String)typeSel.get("YEAR") %> value="YEAR">YEAR</option>
    <option <%= (String)typeSel.get("CHAR") %> value="CHAR">CHAR</option>
    <option <%= (String)typeSel.get("TINYBLOB") %> value="TINYBLOB">TINYBLOB</option>
    <option <%= (String)typeSel.get("TINYTEXT") %> value="TINYTEXT">TINYTEXT</option>
    <option <%= (String)typeSel.get("BLOB") %> value="BLOB">BLOB</option>
    <option <%= (String)typeSel.get("MEDIUMBLOB") %> value="MEDIUMBLOB">MEDIUMBLOB</option>
    <option <%= (String)typeSel.get("MEDIUMTEXT") %> value="MEDIUMTEXT">MEDIUMTEXT</option>
    <option <%= (String)typeSel.get("LONGBOLB") %> value="LONGBOLB">LONGBOLB</option>
    <option <%= (String)typeSel.get("LONGTEXT") %> value="LONGTEXT">LONGTEXT</option>
    <option <%= (String)typeSel.get("ENUM") %> value="ENUM">ENUM</option>
    <option <%= (String)typeSel.get("SET") %> value="SET">SET</option>
    <option <%= (String)typeSel.get("FLOAT") %> value="FLOAT">FLOAT</option>
    <option <%= (String)typeSel.get("TINYINT") %> value="TINYINT">TINYINT</option>
    </select></td>
    <td ><input type="text" name="data_length" size="5" value="<%= fsize %>"></td>
    <td ><select size="1" name="null_value">
    <option <%= (String)typeSel.get("NOT NULL") %> value="NOT NULL">not null</option>
    <option <%= (String)typeSel.get("NULL") %> value="NULL">null</option>
    </select></td>
    <td ><input type="text" name="default_value" value="<%= fdefault %>" size="10"></td>
    
    <td ><select size="1" name="extra">
    <option <%= (String)typeSel.get("NO_ATI") %> value=""></option>
    <option <%= (String)typeSel.get("AUTO_INCREMENT") %> value="AUTO_INCREMENT">AUTO_INCREMENT</option>
    </select>
  </tr>
</table>

<br/><br/>
<input type="hidden" name="type" value="mod_field" />
<input type="hidden" name="field" value="<%= field %>" />
<input type="hidden" name="table" value="<%= table %>" />

<input type="submit" value="Modify" />
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
