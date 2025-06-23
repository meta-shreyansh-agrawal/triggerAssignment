@isTest
private class LeadProcessorTest {

    @isTest
    private static void myUnitTest() {
       List<Lead> leads = new List<Lead>(); 
       for(Integer i = 0; i<200; i++){
        leads.add(new Lead(LastName = 'test'+i, Company = 'TestCo', Title='ATest', Industry = 'Health'));
       }
       insert leads; 

       Test.startTest();
       LeadProcessor lp = new LeadProcessor(); 
       Id batchId = Database.executeBatch(lp,200);
       Test.stopTest();
       

       List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
       System.assertEquals(200, updatedLeads.size()); 
    }
}