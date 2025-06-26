public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        return [SELECT Id,FirstName,LastName,Email,Phone,Fax FROM Contact]; 
    }

    @AuraEnabled
    public static void deleteContact(Id contactId){
        delete [SELECT Id FROM Contact WHERE Id=:contactId];        
    }
}