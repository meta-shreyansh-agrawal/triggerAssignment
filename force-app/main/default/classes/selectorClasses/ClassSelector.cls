public with sharing class ClassSelector extends fflib_SObjectSelector {
     public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
                 Class__c.Id,
                 Class__c.Name,
                 Class__c.Name__c,
                 Class__c.Max_Size__c,
                 Class__c.No_of_Students__c,
                 Class__c.Custom_Status__c
        }; 
    }
     public Schema.SObjectType getSObjectType() {
        return Class__c.sObjectType;
    }
    public List<Class__c> selectById(Set<ID> idSet) {
        return (List<Class__c>) selectSObjectsById(idSet);
    }
}