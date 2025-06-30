public with sharing class PopulateManager {
    public static void populateIntoOpportunities(List<Opportunity> opportunities) {
		System.debug(opportunities); 
        for(Opportunity opp: opportunities){
            if(opp.BillToContact__c==null || opp.Manager__c!=null)return; 
            Id contactId = opp.BillToContact__c;
            // Getting and updating the manager
            Contact con = [SELECT AccountId FROM Contact WHERE ID=:contactId LIMIT 1];
            System.debug(con);
            Account acc = [SELECT Id FROM ACCOUNT WHERE Id=:con.AccountId LIMIT 1];
            System.debug(acc);
            opp.Manager__c=acc.Id;
        }
        System.debug(opportunities); 
        update opportunities; 
    }
}