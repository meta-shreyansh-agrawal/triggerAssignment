public with sharing class TeachSelector extends fflib_SObjectSelector {
     public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
                Teach__c.id,
                Teach__c.Subjects__c, 
                Teach__c.Teacher__c
        };
    }
     public Schema.SObjectType getSObjectType() {
        return Teach__c.sObjectType;
    }
    public List<Teach__c> selectById(Set<ID> idSet) {
        return (List<Teach__c>) selectSObjectsById(idSet);
    }
    public List<Teach__c> selectAllHindiTeachers(){
        return [SELECT ID FROM Teach__c WHERE Subjects__c = 'Hindi'];
    }
}