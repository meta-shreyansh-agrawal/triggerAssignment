@isTest
public class AccountProcessorTest {
    @testSetup
    static void setupData() {
        List<Account> testAccounts = new List<Account>{
            new Account(Name = 'Account One'),
            new Account(Name = 'Account Two')
        };
        insert testAccounts;

        List<Contact> testContacts = new List<Contact>{
            new Contact(FirstName = 'John', LastName = 'Doe', AccountId = testAccounts[0].Id),
            new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = testAccounts[0].Id)
        };
        insert testContacts;
    }

    @isTest
    static void testCountContacts() {
        List<Account> accounts = [SELECT Id, Name FROM Account];
        List<Id> accountIds = new List<Id>();
        for (Account acc : accounts) {
            accountIds.add(acc.Id);
        }

        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest(); 

        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account ORDER BY Name];

        System.assertEquals(2, updatedAccounts.size());
        System.assertEquals(2, updatedAccounts[0].Number_Of_Contacts__c); 
        System.assertEquals(0, updatedAccounts[1].Number_Of_Contacts__c); 
    }

@IsTest
    static void testCountContactsEmptyList() {
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>());
        Test.stopTest();

        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account];
        for (Account a : updatedAccounts) {
            System.assertEquals(null, a.Number_Of_Contacts__c, 'Number_Of_Contacts__c should be null for all accounts');
        }
    }

@IsTest
    static void testCountContactsNullList() {
        Test.startTest();
        AccountProcessor.countContacts(null);
        Test.stopTest();

        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account];
        for (Account a : updatedAccounts) {
            System.assertEquals(null, a.Number_Of_Contacts__c, 'Number_Of_Contacts__c should be null for all accounts');
        }
    }

@IsTest
    static void testCountContactsNoContacts() {
        List<Account> accounts = [SELECT Id, Name FROM Account];
        List<Id> accountIds = new List<Id>();
        for (Account a : accounts) {
            accountIds.add(a.Id);
        }

        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account ORDER BY Name];

        System.assertEquals(2, updatedAccounts.size());
        System.assertEquals(0, updatedAccounts[0].Number_Of_Contacts__c);
        System.assertEquals(0, updatedAccounts[1].Number_Of_Contacts__c);
    }
}