public with sharing class AccountsSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Account.Id,
            Account.Name,
            Account.Description,
            Account.AnnualRevenue
        }; 
    }

    public Schema.SObjectType getSObjectType(){
        return Account.sObjectType;
    }

    public List<Account> selectById(Set<Id> idSet){
        return (List<Account>) selectSObjectsById(idSet);
    }
}