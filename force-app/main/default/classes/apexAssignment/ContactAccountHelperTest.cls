@isTest
private class ContactAccountHelperTest {


@IsTest
    static void testUpdateAccountContactIDs(){
        Account a = new Account(Name = 'Test Account');
        insert a; 

        Contact con = new Contact(LastName = 'Test Contact', AccountId = a.Id);
        insert con; 

        ContactAccountHelper.updateAccountContactIDs(con.Id);

        a = [SELECT ContactIDs__c FROM Account WHERE ID = :a.Id];
        System.assert(a.ContactIDs__c.contains(con.Id));
    }
}