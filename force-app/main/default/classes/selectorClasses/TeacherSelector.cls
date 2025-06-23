public with sharing class TeacherSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
                Contact.Id,
                Contact.Name,
                Contact.MailingCity,
                Contact.AccountId
        };
    }
     public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }
    public List<Contact> selectById(Set<ID> idSet) {
        return (List<Contact>) selectSObjectsById(idSet);
    }

    public Map<Opportunity,Id> getOppToAccMap(Map<Id,Opportunity> contactMap){
        List<Contact> conList = selectById(contactMap.keySet()); 
        Map<Opportunity,Id> oppToAccMap = new Map<Opportunity,Id>();
        for(Contact con:conList){
            if(con.AccountId!=null){
                oppToAccMap.put( contactMap.get(con.Id) ,con.AccountId);
            }
        }
        return oppToAccMap;
    }

    public List<Contact> selectContactByAccountId(List<Id> accountIds){
        return [SELECT Id,MailingCity,AccountId FROM Contact WHERE AccountId in :accountIds];  
        
        // (List<Contact>)Database.query(
        //     newQueryFactory()
        //     .setCondition('AccountId in :'+accountIds)
        //     .toSOQL()
        // ); 
    }

}