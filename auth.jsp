<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,java.io.*,jmk.*" %>
<%@page errorPage="/error.jsp" %>

<%
// read config setting from config.ini
    String jdbc = "com.mysql.jdbc.Driver";  // default JDBC driver
    String configFile = application.getRealPath("/")+"/WEB-INF/config.ini"; // config.ini location
    String mode = (String)request.getParameter("mode"); // login mode
    String ip = (String)request.getRemoteAddr();    // remote IP
    Properties pp = new Properties();
    FileInputStream fi = null;
    try{
        fi = new FileInputStream(configFile);
        pp.load(fi);
    }catch(FileNotFoundException e){
        out.println(e);
    }catch(IOException e){
        out.println(e);
    }
    jdbc = pp.getProperty("jdbc");
    
    // change session time
    int sessTime = 300;
    try{
        sessTime = Integer.parseInt(pp.getProperty("session")) * 60;
    }catch(Exception e){}
    session.setMaxInactiveInterval(sessTime);

// users data
String host = (String)request.getParameter("host");
String port = (String)request.getParameter("port");
String db = (String)request.getParameter("database");
String user = (String)request.getParameter("user");
String pass = (String)request.getParameter("password");

// System Admin data
if(mode != null && mode.equals("admin") && ip.equals("127.0.0.1")){
    host = pp.getProperty("host");
    port = pp.getProperty("port");
    db = pp.getProperty("db");
    user = pp.getProperty("user");
    pass = pp.getProperty("pass");
}else{
    mode = "outer user";
}
    ConDB dbcon = new ConDB(jdbc);
    session.setAttribute("dbcon", dbcon);
    
if (dbcon.open(host,port,db, user, pass)){
    // set a login = "Y" for login
    session.setAttribute("login", "Y");
    session.setAttribute("user", user);
    session.setAttribute("db", db);
    session.setAttribute("sqlHistory", new Vector());
    System.out.println("==== Login ====");
    System.out.println("Date  : " + new java.util.Date() );
    System.out.println("IP    : " + ip );
    System.out.println("Mode  : " + mode );
    System.out.println("DB    : " + db );
    System.out.println("User  : " + user );
%>
<html>

<head>
<title>jspMyAdmin</title>
</head>

<frameset cols="200,*">
  <frame name="menu" src="./myadmin/menu.jsp" target="main">
  <frame name="main" src="./myadmin/main.jsp">
  <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>
<%
}else{
    session.invalidate();
%>
<html>
<!-- import the CSS & JavaScript -->
<link rel="stylesheet" type="text/css" href="./css/mystyle.css" />
<script src="./js/sql.js"></script>
<!-- import ended -->
<h2 align="center">Login failed!</h2>
<h2 align="center">Please try again!</h2>
<h2 align="center"><a href="login.jsp">Login</a></h2>
</html>
<%
}
%>


