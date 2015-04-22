/*
 * MyUnique.java
 *
 * Created on 2004年11月19日, 下午 9:52
 */

package jmk;
import java.util.*;
/**
 *
 * @author  karl
 */
// a class of Index, a keyName and it's related fields
public class MyIndex {
    private String keyName;
    private Vector field;
    /** Creates a new instance of MyUnique */
    public MyIndex(String keyName) {
        this.keyName = keyName;
        this.field = new Vector();
    }
    
    public void add(String fieldName){
        field.add(fieldName);
    }
    
    public String getKeyName(){
        return keyName;
    }
    
    public Vector getField(){
        return field;
    }
}
