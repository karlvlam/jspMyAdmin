/*
 * GenSQL.java
 *
 * Created on 2004年11月11日, 下午 11:25
 */

package jmk;
import java.util.*;
/**
 *
 * @author  karl
 */
public class GenSQL {
    static String fq = "`"; // data field quto
    static String tq = "'"; //  string quto
    /** Creates a new instance of GenSQL */
    public GenSQL() {

    }
    // gen SQL command for create table
    public static String genCreateTB(int number, String table, String[] field_name, String[] data_type, String[] data_length,
        String[] null_value, String[] default_value, String[] extra, String[] key){
            
        String sql = "";
        boolean primaryFound = false;
        boolean indexFound = false;
        boolean uniqueFound = false;
        // start CREATE TABLE command
	sql += "CREATE TABLE " + fq + table + fq + " ( " ;

        for(int i=0; i < number; i++){
            String dfield = "";
            String dtype = "";
            String dlength = "";
            String ddefault = "";
            String dnull = "";
            String dextra = "";
          
            // field string
                dfield = fq + field_name[i].trim() + fq ;
            // data_type string
            dtype = " " + data_type[i] ;
            
            // data length string
            if (data_length[i].trim().equals("")){
		dlength = "";
	    }else{
                dlength = " (" + data_length[i].trim() + ")";
	    }
            // default_value string
            if(!default_value[i].trim().equals("")){
                if (data_type[i].equals("CHAR") || data_type[i].equals("VARCHAR") || 
                    data_type[i].equals("TEXT") || data_type[i].equals("TINYTEXT") || 
                    data_type[i].equals("MEDIUMTEXT") || data_type[i].equals("LONGTEXT")){
                        ddefault = " DEFAULT " + tq + default_value[i] + tq ;
                }else{
                    ddefault = " DEFAULT " + default_value[i];
                }
            }
            
            // null_value string
            dnull = " " + null_value[i];
            
            // extra
            dextra = " " + extra[i];

            sql +=  "\n\t" + dfield + dtype + dlength + ddefault + dnull + dextra + ",";

        }
        // PRIMARY KEY command
        for (int i=0; i < number; i++){
            
            if (key[i].trim().equals("PRIMARY")){
                if (!primaryFound){
                    sql += "\n\t" + "PRIMARY KEY (";
                    primaryFound = true;
                }
                sql += fq + field_name[i].trim() + fq + ",";
            }

        }
        if (primaryFound)
            sql = sql.substring(0,sql.length()-1) + "),";
        
        // INDEX command
        for (int i=0; i < number; i++){
            
            if (key[i].trim().equals("INDEX")){
                if (!indexFound){
                    sql += "\n\t" + "INDEX (";
                    indexFound = true;
                }
                sql += fq + field_name[i].trim() + fq + ",";
            }

        }
        if (indexFound)
            sql = sql.substring(0,sql.length()-1) + "),";

        // UNIQUE command
        for (int i=0; i < number; i++){
            
            if (key[i].trim().equals("UNIQUE")){
                if (!uniqueFound){
                    sql += "\n\t" + "UNIQUE (";
                    uniqueFound = true;
                }
                sql += fq + field_name[i].trim() + fq + ",";
            }

        }
        if (uniqueFound)
            sql = sql.substring(0,sql.length()-1) + "),";
        // end the command
        sql = sql.substring(0,sql.length()-1) + "\n);";
        return sql;
    }

    // gen SQL command for adding fields
    public static String genAddFD(int number, String table, String[] field_name, String[] data_type, String[] data_length,
        String[] null_value, String[] default_value, String[] extra, String after) {
        String sql = "ALTER TABLE " + fq + table + fq;
        
        for(int i=0; i < number; i++){
            String dfield = "";
            String dtype = "";
            String dlength = "";
            String ddefault = "";
            String dnull = "";
            String dextra = "";
          
            // field string
                dfield = fq + field_name[i].trim() + fq ;
            // data_type string
            dtype = " " + data_type[i] ;
            
            // data length string
            if (data_length[i].trim().equals("")){
		dlength = "";
	    }else{
                dlength = " (" + data_length[i].trim() + ")";
	    }
            // default_value string
            if(!default_value[i].trim().equals("")){
                if (data_type[i].equals("CHAR") || data_type[i].equals("VARCHAR") || 
                    data_type[i].equals("TEXT") || data_type[i].equals("TINYTEXT") || 
                    data_type[i].equals("MEDIUMTEXT") || data_type[i].equals("LONGTEXT")){
                        ddefault = " DEFAULT " + tq + default_value[i] + tq ;
                }else{
                    ddefault = " DEFAULT " + default_value[i];
                }
            }
            
            // null_value string
            dnull = " " + null_value[i];
            
            // extra
            dextra = " " + extra[i];

            sql +=  "\n\tADD " + dfield + dtype + dlength + ddefault + dnull + dextra + ",";

        }
        // remove the last ","
        sql = sql.substring(0,sql.length()-1);
        if (after.equals("--end--")){
            // end the command
            sql += ";";
            
        }else if(after.equals("--first--")){
            sql += "\n\tAFTER FIRST;";
        }else{
            sql += "\n\tAFTER " + fq + after + fq + ";";
        }
        return sql;
    }    
    // gen SQL command for modifing field
   public static String genModFD(String table, String old_name, String field_name, String data_type, String data_length,
        String null_value, String default_value, String extra) {
        String sql = "ALTER TABLE " + fq + table + fq + " CHANGE " + fq + old_name + fq;
        
            String dfield = "";
            String dtype = "";
            String dlength = "";
            String ddefault = "";
            String dnull = "";
            String dextra = "";
          
            // field string
                dfield = fq + field_name.trim() + fq ;
            // data_type string
            dtype = " " + data_type ;
            
            // data length string
            if (data_length.trim().equals("")){
		dlength = "";
	    }else{
                dlength = " (" + data_length.trim() + ")";
	    }
            // default_value string
            if(!default_value.trim().equals("")){
                if (data_type.equals("CHAR") || data_type.equals("VARCHAR") || 
                    data_type.equals("TEXT") || data_type.equals("TINYTEXT") || 
                    data_type.equals("MEDIUMTEXT") || data_type.equals("LONGTEXT")){
                        ddefault = " DEFAULT " + tq + default_value + tq ;
                }else{
                    ddefault = " DEFAULT " + default_value;
                }
            }
            
            // null_value string
            dnull = " " + null_value;
            
            // extra
            dextra = " " + extra;

            sql +=  "\n\t " + dfield + dtype + dlength + ddefault + dnull + dextra + ";";

        return sql;
    }    
   
   // do some adjustment on a SQL command
    public static String adjSQL(String sql){
        sql = sql.trim();
        if (!sql.endsWith(";"))
            sql += ";";
        return sql;
    }
    
}
