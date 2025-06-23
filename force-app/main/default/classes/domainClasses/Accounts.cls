public class Accounts extends fflib_SObjectDomain {
    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<Account> sObjectList) {
            return new Accounts(sObjectList);
        }
    }

    public void createNewOpportunity(){
        List<Account> records = (List<Account>) Records;
        List<Opportunity> OpportunityList = new List<Opportunity>(); 
        for(Account acc: records){
            if(acc.Industry == 'Agriculture'){
                Opportunity opp = new Opportunity();
                opp.AccountId = acc.Id; 
                opp.Name = acc.Name + ' - opp';
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today(); 
                OpportunityList.add(opp); 
            }
        }
        if(!OpportunityList.isEmpty()){
            insert OpportunityList; 
        }
    }

    public override void onAfterInsert(){
        createNewOpportunity();
    }
    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
        createNewOpportunity();

        // updating billing city of accounts
        Map<Id,String> accToUpdate = new Map<Id,String>();
        for(Account acc : (List<Account>) Records){
            Account oldRecord = (Account)existingRecords.get(acc.Id);
            if(acc.BillingCity != oldRecord.BillingCity){
                accToUpdate.put(acc.Id,acc.BillingCity);
            }
        }

        // update contact mailing city of these records
        TeacherService.updateContactMailingCity(accToUpdate); 

    }
}