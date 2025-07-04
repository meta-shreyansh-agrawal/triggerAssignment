public with sharing class Accounts extends fflib_SObjectDomain{
    public Accounts(List<Account> sObjectList){
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }
    
    public override void onApplyDefaults(){
        for(Account account: (List<Account>) Records){
            account.Description = 'Domain classes rock!'; 
        }
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
        for(Account acc: (List<Account>) Records){
            String line = 'Domain classes rock!';
            acc.AnnualRevenue = line.getLevenshteinDistance(acc.Description);  
        }
    }
}