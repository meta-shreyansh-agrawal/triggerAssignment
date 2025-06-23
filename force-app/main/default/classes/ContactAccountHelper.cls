public with sharing class ContactAccountHelper {
    public static void updateAccountContactIDs(Id contactId){
        if(contactId == null)return; 

        // Get the account that is related to this contact
        Contact contact = [SELECT Id,AccountId FROM Contact WHERE ID = :contactId LIMIT 1];
        if(contact.AccountId == null) return;
        Account acc = [SELECT Id,ContactIDs__c FROM Account WHERE ID = :contact.AccountId LIMIT 1];
        
        // If contactIDs of account is empty add all contact ids to it
        if(String.isBlank(acc.ContactIDs__c)){
            List<Contact> relatedContacts = [SELECT Id FROM Contact WHERE AccountId = :acc.Id];
            List<String> conIds = new List<String>();
            for(Contact c: relatedContacts){
                conIds.add(c.Id);
            }
            acc.ContactIDs__c = String.join(conIds, ',');
            update acc;
        }else{ // Add this contact id if other exists
            List<String> conIds = acc.ContactIDs__c.split(',');
            if(!conIds.contains(contactId)){
                conIds.add(contactId);
            }
            acc.ContactIDs__c = String.join(conIds, ','); 
            update acc; 
        }
    }
}