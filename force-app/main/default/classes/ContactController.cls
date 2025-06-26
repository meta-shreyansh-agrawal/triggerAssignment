public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        return [SELECT Id,FirstName,LastName,Email,Phone,Fax FROM Contact]; 
    }

    @AuraEnabled
    public static void deleteContact(String contactId){
        try{
            delete [SELECT Id FROM Contact WHERE Id=:contactId];
        }catch(DmlException e){
            throw e;
        }
    }
}