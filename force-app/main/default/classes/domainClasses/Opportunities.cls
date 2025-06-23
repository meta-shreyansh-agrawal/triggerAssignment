public with sharing class Opportunities extends fflib_SObjectDomain {
    public Opportunities(List<Opportunity> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<Opportunity> sObjectList) {
            return new Opportunities(sObjectList);
        }
    }
    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
        for(Opportunity opp : (List<Opportunity>) Records){
            Opportunity old = (Opportunity)existingRecords.get(opp.Id);
            if( old.StageName != 'Closed Won' && old.StageName != 'Closed Lost' ){
                if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost'){
                    opp.CloseDate = Datetime.now().date();
                }
            }
        }


        // Last Trigger Question

        List<Opportunity> opportunityList = (List<Opportunity>) Records; 
        Map<Id,Opportunity> contactList = new Map<Id,Opportunity>(); 
        for(Opportunity opp: opportunityList){
            if(opp.BillToContact__c != null && opp.Manager__c == null) {
                contactList.put(opp.BillToContact__c,opp); 
            }
        }
        // fetch all contacts and accountIds of contacts as a map of oppId and accountId 
        Map<Opportunity,Id> opportunityToAccountId = new TeacherSelector().getOppToAccMap(contactList); 
        // set manager as accountId; 
        for(Opportunity opp: opportunityList){
             if(opp.BillToContact__c != null && opp.Manager__c == null) {
                if(opportunityToAccountId.containsKey(opp)){
                    opp.Manager__c = opportunityToAccountId.get(opp);
                }
            }
        }
    

    }

}