public with sharing class TeacherService {
    public static void updateContactMailingCity(Map<Id,String> accounts){
        // get all contacts of these accounts
        List<Contact> contactList = new TeacherSelector().selectContactByAccountId(new List<Id>(accounts.keySet())); 
        // update their mailing city
         fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[]{
                Contact.SObjectType
            }
        );

        for(Contact con: contactList){
            con.MailingCity = accounts.get(con.AccountId); 
            uow.registerDirty(con);
        }
        //commit work 
        uow.commitWork();
    }
}