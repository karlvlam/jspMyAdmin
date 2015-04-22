/*
 * ConMySQL.java
 *
 * Created on October 28, 2004, 12:40 PM
 */

package jmk;

import java.sql.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
/**
 *
 * @author  root
 */
public class ConDB implements HttpSessionBindingListener{
    
    private Connection conn = null;
    
    /** Creates a new instance of ConMySQL */
    public ConDB(String jdbc) {
        // create a DB connection
        try{
            Class.forName(jdbc).newInstance();
        }catch(Exception e){System.out.println(e);}

    }
    
    public boolean open(String host, String port, String db, String user, String pass){
        close();
        conn = null;
        // deal with the port range error
        try{
            int p = Integer.parseInt(port);
            if(p < 0 || p > 65535){
                port = "3306";
            }
        }catch(NumberFormatException e){
            port = "3306";
        }
        String sql = "jdbc:mysql://"+host+":"+port+"/"+db+"?user="+user+"&password="+pass;
        
        // try to connect the DB, retrun true if ok
        try{ 
            conn = DriverManager.getConnection(sql);
        }catch(Exception e){System.out.println(e);}
        
        if (conn == null){
            return false;
        }
        return true;
        
    }
    
    public void close(){
        try{
            conn.close();
            conn = null;
            
        }catch(Exception e){}
    }
    

    
    public Connection get(){
        return conn;
    }
    
    public boolean login(){
        if (conn == null)
            return false;
        return true;
    }
    
    public void valueBound(HttpSessionBindingEvent event) {

    }
    
    public void valueUnbound(HttpSessionBindingEvent event) {
        if (conn != null)
            close();
    }
    
}
