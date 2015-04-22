package jmk;
import java.util.*;

// class for Primary Key, Unique Keys, and Indexs
public class MyConstraint {

    private Vector pk;
    private Vector uk;
    private Vector idx;
    /** Creates a new instance of MyIndex */
    public MyConstraint() {
        pk = new Vector();  // Primary Key
        uk = new Vector();  // Uniques
        idx = new Vector(); // Indexs
    }
    public boolean add(char nu, String keyName, String fieldName){
        MyIndex ti;
        // add field to Primary Key
        if(keyName.equals("PRIMARY")){
            pk.add(fieldName);
            return true;
            
        // add to Unique
        }else if(nu == '0'){
            for(int i=0; i < uk.size(); i++){
                ti = (MyIndex)uk.get(i);
                if(ti.getKeyName().equals(keyName)){
                    ti.add(fieldName);
                    return true;
                }
            }
            ti = new MyIndex(keyName);
            ti.add(fieldName);
            uk.add(ti);
            return true;
            
        // add to Index
        }else if(nu == '1'){
            for(int i=0; i < idx.size(); i++){
                ti = (MyIndex)idx.get(i);
                if(ti.getKeyName().equals(keyName)){
                    ti.add(fieldName);
                    return true;
                }
            }
            ti = new MyIndex(keyName);
            ti.add(fieldName);
            idx.add(ti);
            return true;            
        }
        return false;
    }
    public Vector getPk(){ return pk; }    
    public Vector getUk(){ return uk; }    
    public Vector getIdx(){ return idx; }
    public int size(){ return (pk.size() + uk.size() + idx.size()); }
}


