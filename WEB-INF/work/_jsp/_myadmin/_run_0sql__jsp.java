/*
 * JSP generated by Resin-3.0.s041002 (built Sat, 02 Oct 2004 04:47:31 PDT)
 */

package _jsp._myadmin;
import javax.servlet.*;
import javax.servlet.jsp.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import jmk.*;

public class _run_0sql__jsp extends com.caucho.jsp.JavaPage{
  private boolean _caucho_isDead;
  
  public void
  _jspService(javax.servlet.http.HttpServletRequest request,
              javax.servlet.http.HttpServletResponse response)
    throws java.io.IOException, javax.servlet.ServletException
  {
    javax.servlet.http.HttpSession session = request.getSession(true);
    com.caucho.server.webapp.Application _jsp_application = _caucho_getApplication();
    javax.servlet.ServletContext application = _jsp_application;
    com.caucho.jsp.PageContextImpl pageContext = com.caucho.jsp.QJspFactory.allocatePageContext(this, _jsp_application, request, response, "/error.jsp", session, 8192, true);
    javax.servlet.jsp.JspWriter out = pageContext.getOut();
    javax.servlet.ServletConfig config = getServletConfig();
    javax.servlet.Servlet page = this;
    response.setContentType("text/html");
    try {
      out.write(_jsp_string0, 0, _jsp_string0.length);
      
String sql_type = request.getParameter("type");
String sql = "";
String table = request.getParameter("table");
String field = request.getParameter("field");
String sql_key = request.getParameter("key");
String after = request.getParameter("after");
int hist_rec = 0;
try{
    hist_rec = Integer.parseInt((String)request.getParameter("hist_rec"));
}catch(Exception e){}

// SQL event (the provided functions of this system)
if (sql_type != null){
    
    String fq = "`";
    
    if(sql_type.equals("run")){
        sql = request.getParameter("sql");
    }else if(sql_type.equals("history")){
        // get SQL history
        sql = ((Vector)session.getAttribute("sqlHistory")).get(hist_rec).toString();
        
    }else if(sql_type.equals("drop_tb") && table != null){
        // run DROP TABLE command
        sql = "drop table " + fq + table + fq;
        
    }else if(sql_type.equals("empty_tb") && table != null){
        // run DELETE command without any condition (empty table)
        sql = "delete from " + fq + table + fq;
        
    }else if(sql_type.equals("browse") && table != null){
        // run SELECT * FROM command without any condition (show all record)
        sql = "select * from " + fq + table + fq;
        
    }else if(sql_type.equals("drop_fd") && table != null && field != null){
        // DROP field
        sql = "ALTER TABLE " + fq + table + fq +" DROP "  + fq + field + fq;
        
    }else if(sql_type.equals("create_table") && table != null){
        // run CREATE TABLE command
        int number = 1;
        try{
        number = Integer.parseInt(request.getParameter("field_number"));
        }catch(Exception e){};

        // init the create table data
        String[] field_name  = request.getParameterValues("field[]");
        String[] data_type  = request.getParameterValues("data_type[]");
        String[] data_length  = request.getParameterValues("data_length[]");
        String[] null_value  = request.getParameterValues("null_value[]");
        String[] default_value  = request.getParameterValues("default_value[]");
        String[] extra  = request.getParameterValues("extra[]");
        String[] key  = new String[number];
        
        for(int i=0; i < number; i++){
            key[i] = request.getParameter("key_" + i);
        }
        
        sql = GenSQL.genCreateTB(number,table,field_name,data_type,data_length,null_value,default_value,extra,key);

    }else if(sql_type.equals("add_field")){
        // ADD FIELDS into a table
        int number = 1;
        try{
        number = Integer.parseInt(request.getParameter("field_number"));
        }catch(Exception e){};

        // init the add fields data
        String[] field_name  = request.getParameterValues("field[]");
        String[] data_type  = request.getParameterValues("data_type[]");
        String[] data_length  = request.getParameterValues("data_length[]");
        String[] null_value  = request.getParameterValues("null_value[]");
        String[] default_value  = request.getParameterValues("default_value[]");
        String[] extra  = request.getParameterValues("extra[]");
        sql = GenSQL.genAddFD(number,table,field_name,data_type,data_length,null_value,default_value,extra,after);
        
    }else if(sql_type.equals("mod_field") && table != null && field != null){
        // init the mod field data
        String field_name  = request.getParameter("field_name");
        String data_type  = request.getParameter("data_type");
        String data_length  = request.getParameter("data_length");
        String null_value  = request.getParameter("null_value");
        String default_value  = request.getParameter("default_value");
        String extra  = request.getParameter("extra");
        sql = GenSQL.genModFD(table,field,field_name,data_type,data_length,null_value,default_value,extra);
        
    }else if(sql_type.equals("new_pk") && table != null && field != null){
        // NEW Primary Key
        sql = "ALTER TABLE `"+table+"` DROP PRIMARY KEY, ADD PRIMARY KEY ( `"+field+"` ) ";
        
    }else if(sql_type.equals("new_uni") && table != null && field != null){
        // make Unique
        sql = "ALTER TABLE `"+table+"` ADD UNIQUE (`"+field+"`) ";
        
    }else if(sql_type.equals("new_idx") && table != null && field != null){
        // add Index
        sql = "ALTER TABLE `"+table+"` ADD INDEX ( `"+field+"` ) ";
        
    }else if(sql_type.equals("drop_key") && table != null && sql_key != null){
        // drop key
        if (sql_key.equals("PRIMARY")){
            sql = "ALTER TABLE `"+table+"` DROP PRIMARY KEY";
        }else{
            sql = "ALTER TABLE `"+table+"` DROP INDEX  `"+sql_key+"`";
        }
        
    }else if(sql_type.equals("create_index") && table != null && sql_key != null){
        // create indexs
        String fields[] = request.getParameterValues("field[]");
        String name = request.getParameter("index").trim();
        if(!name.equals("")){
            name = fq + name + fq;
        }
        String tmp = "";
        for(int i=0;i < fields.length; i++){
            tmp += fq + fields[i] + fq + ",";
        }
        tmp = tmp.substring(0, tmp.lastIndexOf(","));
        if(sql_key.equals("PRIMARY")){
            sql = "ALTER TABLE `"+table+"` DROP PRIMARY KEY, ADD PRIMARY KEY ( "+tmp+" ) ";
        }else if(sql_key.equals("INDEX")){
            sql = "ALTER TABLE `"+table+"` ADD INDEX "+name+" ( "+tmp+" )";
        }else if(sql_key.equals("UNIQUE")){
            sql = "ALTER TABLE `"+table+"` ADD UNIQUE "+name+" ( "+tmp+" )";
        }
    }else{
        // Error, empty SQL command
        sql = "";
    }
    
    // Adjust the SQL command
    sql = GenSQL.adjSQL(sql);


      out.write(_jsp_string1, 0, _jsp_string1.length);
      out.print(( sql ));
      out.write(_jsp_string2, 0, _jsp_string2.length);
      

ConDB dbcon = (ConDB)session.getAttribute("dbcon");
Connection conn = dbcon.get();
PreparedStatement pstm = conn.prepareStatement(sql);
try{
    if (pstm.execute()){
        // if the command is SELECT
        int rownum = 0;
        boolean showheader = false;
        ResultSet rs = pstm.getResultSet();
        ResultSetMetaData rsm = rs.getMetaData();
        int fnum = rsm.getColumnCount();
        String[] fname = new String[fnum];
        int[] ftype = new int[fnum];
        String[] ftypet = new String[fnum];

        for(int i=0;i<fnum;i++){
            fname[i] = rsm.getColumnLabel(i+1);
            ftype[i] = rsm.getColumnType(i+1);
            ftypet[i] = rsm.getColumnTypeName(i+1);
            //out.println(fname[i] + "|" + ftype[i] + "|" + ftypet[i] + "<br/>");
            
        }

        while(rs.next()){

            //show the Field Names
            if (!showheader){
                out.println("<table border='0'>\n<tr>");
                for(int i=0; i<fnum;i++){
                    out.println("<td class='tb_header'>"+ fname[i]+"</td>");
                }
                out.println("</tr>");
                showheader = true;
            }

            // show the Results
            out.println("<tr>");
            for(int i=0; i<fnum;i++){
                out.println("<td class='tb_row_" + (rownum & 1) + "'>" + rs.getString(i+1) + "&nbsp;</td>");
            }
            out.println("</tr>");
                        
            rownum++;

        }
        out.println("</table>");
        out.println(rownum + " records found.");

    }else{
        // if the command is UPDATE
        int updateCount = pstm.getUpdateCount();
        out.println(updateCount + " rows affected.");
    }
    out.println("<hr/>SQL command executed successfully.");
    Vector history = (Vector)session.getAttribute("sqlHistory");
    history.add(sql);
    
}catch(SQLException e){
    // show error mess
    String errMess = e.getMessage();
    errMess = errMess.substring(errMess.indexOf("\"")+1, errMess.lastIndexOf("\""));
    errMess = "#" + e.getErrorCode() + " --- " + errMess;
    out.println("SQL command error...<hr/>MySQL said:<br/><br/>");
    out.println(errMess + "<br/>");
    
}

}else{
    out.println("Error!");
}

      out.write(_jsp_string3, 0, _jsp_string3.length);
      out.print(( sql ));
      out.write(_jsp_string4, 0, _jsp_string4.length);
      
    if(sql_type.equals("create_table") || sql_type.equals("drop_tb")){

      out.write(_jsp_string5, 0, _jsp_string5.length);
       } 
      out.write(_jsp_string6, 0, _jsp_string6.length);
    } catch (java.lang.Throwable _jsp_e) {
      pageContext.handlePageException(_jsp_e);
    } finally {
      com.caucho.jsp.QJspFactory.freePageContext(pageContext);
    }
  }

  private com.caucho.java.LineMap _caucho_line_map;
  private java.util.ArrayList _caucho_depends = new java.util.ArrayList();

  public java.util.ArrayList _caucho_getDependList()
  {
    return _caucho_depends;
  }

  public void _caucho_addDepend(com.caucho.make.PersistentDependency depend)
  {
    super._caucho_addDepend(depend);
    _caucho_depends.add(depend);
  }

  public boolean _caucho_isModified()
  {
    if (_caucho_isDead)
      return true;
    if (com.caucho.util.CauchoSystem.getVersionId() != -1589519462977561320L)
      return true;
    for (int i = _caucho_depends.size() - 1; i >= 0; i--) {
      com.caucho.make.Dependency depend;
      depend = (com.caucho.make.Dependency) _caucho_depends.get(i);
      if (depend.isModified())
        return true;
    }
    return false;
  }

  public long _caucho_lastModified()
  {
    return 0;
  }

  public com.caucho.java.LineMap _caucho_getLineMap()
  {
    return _caucho_line_map;
  }

  public void destroy()
  {
      _caucho_isDead = true;
      super.destroy();
  }

  public void init(com.caucho.java.LineMap lineMap,
                   com.caucho.vfs.Path appDir)
    throws javax.servlet.ServletException
  {
    com.caucho.vfs.Path resinHome = com.caucho.util.CauchoSystem.getResinHome();
    com.caucho.vfs.MergePath mergePath = new com.caucho.vfs.MergePath();
    mergePath.addMergePath(appDir);
    mergePath.addMergePath(resinHome);
    com.caucho.loader.DynamicClassLoader loader;
    loader = (com.caucho.loader.DynamicClassLoader) getClass().getClassLoader();
    String resourcePath = loader.getResourcePathSpecificFirst();
    mergePath.addClassPath(resourcePath);
    _caucho_line_map = new com.caucho.java.LineMap("_run_0sql__jsp.java", "foo");
    _caucho_line_map.add("/myadmin/run_sql.jsp", 6, 31);
    _caucho_line_map.add(147, 167);
    _caucho_line_map.add(149, 169);
    _caucho_line_map.add(224, 243);
    _caucho_line_map.add(233, 245);
    _caucho_line_map.add(237, 249);
    com.caucho.vfs.Depend depend;
    depend = new com.caucho.vfs.Depend(appDir.lookup("myadmin/run_sql.jsp"), "hrwoy4+6zS9mwa/YEsc/eQ==", false);
    _caucho_depends.add(depend);
  }

  private final static char []_jsp_string1;
  private final static char []_jsp_string2;
  private final static char []_jsp_string4;
  private final static char []_jsp_string5;
  private final static char []_jsp_string3;
  private final static char []_jsp_string6;
  private final static char []_jsp_string0;
  static {
    _jsp_string1 = "\n<!-- import the CSS & JavaScript -->\n<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/mystyle.css\" />\n<script src=\"../js/sql.js\"></script>\n<!-- import ended -->\n<body>\nThe following SQL command has been executed:\n<pre>".toCharArray();
    _jsp_string2 = "</pre>\n<hr/>\n".toCharArray();
    _jsp_string4 = "</textarea>\n    <br/>\n    <!-- hidden values, don't miss them -->\n    <input type=\"hidden\" name=\"type\" value=\"run\"/>\n    <input type=\"submit\" value=\"Run\"/>\n    &nbsp;&nbsp;&nbsp;&nbsp;\n    <input type=\"reset\" value=\"Reset\"/>\n</form>\n</body>\n".toCharArray();
    _jsp_string5 = "\n<script>parent.frames(\"menu\").location.href=\"menu.jsp\"</script>\n".toCharArray();
    _jsp_string3 = "\n<hr/>\n<form method=\"post\">\n<textarea name=\"sql\" rows=\"10\" cols=\"40\">".toCharArray();
    _jsp_string6 = "\n</html>".toCharArray();
    _jsp_string0 = "\n\n\n\n\n".toCharArray();
  }
}
