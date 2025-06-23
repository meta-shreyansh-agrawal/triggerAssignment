public with sharing class StringListTest {
    public static List<String> generateStringList(Integer n){
        
        List<String> retrunList = new List<String>();
        for(Integer i = 0; i<n; i++){
            retrunList.add('Test'+i); 
        }
        
        return retrunList;
    }
}