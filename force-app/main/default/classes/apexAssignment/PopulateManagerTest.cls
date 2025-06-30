@isTest
private class PopulateManagerTest {


@IsTest
    static void test() {
        Account a = new Account(Name='Test Account');
        insert a;
        Contact con = new Contact(LastName='Test Contact', AccountId=a.Id);
        insert con;
        Opportunity opp = new Opportunity(Name='Test Opportunity', StageName='Prospecting', CloseDate=Date.today(), BillToContact__c=con.Id);
        insert opp;
        PopulateManager.populateIntoOpportunities(new List<Opportunity>{opp});
        opp = [SELECT Manager__c FROM Opportunity WHERE Id=:opp.Id LIMIT 1];
        System.assertEquals(a.Id, opp.Manager__c);
    }
}