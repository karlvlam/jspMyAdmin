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

public class _mod_0hist__jsp extends com.caucho.jsp.JavaPage{
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
      
    int hist_rec = 0;
    String sql = "";
    Vector history = (Vector)session.getAttribute("sqlHistory");
    try{
        hist_rec = Integer.parseInt(request.getParameter("hist_rec"));
        sql = (String)history.get(hist_rec);
    }catch(Exception e){
        sql = "";
    }

      out.write(_jsp_string1, 0, _jsp_string1.length);
      out.print(( sql ));
      out.write(_jsp_string2, 0, _jsp_string2.length);
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
    _caucho_line_map = new com.caucho.java.LineMap("_mod_0hist__jsp.java", "foo");
    _caucho_line_map.add("/myadmin/mod_hist.jsp", 5, 31);
    _caucho_line_map.add(25, 43);
    com.caucho.vfs.Depend depend;
    depend = new com.caucho.vfs.Depend(appDir.lookup("myadmin/mod_hist.jsp"), "eiTLUEo5qVITXoEfkZingg==", false);
    _caucho_depends.add(depend);
  }

  private final static char []_jsp_string0;
  private final static char []_jsp_string1;
  private final static char []_jsp_string2;
  static {
    _jsp_string0 = "\n\n\n\n".toCharArray();
    _jsp_string1 = "\n<html>\n<head><title>JSP Page</title></head>\n<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/mystyle.css\" />\n<script src=\"../js/sql.js\"></script>\n<!-- import ended -->\n<body>\n<h2>Modify History</h2>\n<hr/>\n<form action=\"run_sql.jsp\" method=\"post\">\n<textarea name=\"sql\" rows=\"20\" cols=\"80\">".toCharArray();
    _jsp_string2 = "</textarea>\n    <br/>\n    <!-- hidden values, don't miss them -->\n    <input type=\"hidden\" name=\"type\" value=\"run\"/>\n    <input type=\"submit\" value=\"Run\"/>\n    &nbsp;&nbsp;&nbsp;&nbsp;\n    <input type=\"reset\" value=\"Reset\"/>\n</form>\n</body>\n</html>\n".toCharArray();
  }
}
