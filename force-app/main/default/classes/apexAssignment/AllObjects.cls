public with sharing class AllObjects {
	public static List<String> getAllSObjectNames() {
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        List<String> objectNames = new List<String>();
    
        for (String objectApiName : globalDescribe.keySet()) {
            objectNames.add(objectApiName);
        }
    
        return objectNames;
	}
}