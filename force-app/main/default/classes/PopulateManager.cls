public with sharing class PopulateManager {
    public static void PopulateManager(List<Opportunity> opportunities) {
        for(Opportunity opp: opportunities){
            if(opp.BillToContact__c==null || opp.Manager__c!=null)return; 
            Id contactId = opp.BillToContact__c;
            Contact con = [SELECT AccountId FROM Contact WHERE ID=:contactId LIMIT 1];
            Account acc = [SELECT Id FROM ACCOUNT WHERE Id=:con.AccountId LIMIT 1];
            opp.Manager__c=acc.Id;
        }
        update opportunities; 
    }
}