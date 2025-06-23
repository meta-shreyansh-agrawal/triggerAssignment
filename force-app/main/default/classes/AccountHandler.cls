public with sharing class AccountHandler {
    public static Account insertNewAccount(string accName) {
        try {
            if(accName=='' || accName==null)throw new DmlException('Enter non empty account name'); 
            Account acc = new Account(name = accName); 
            insert acc; 
            return acc; 
        } catch (DmlException e) {
            System.debug('A DML exception has occurred: ' +
            e.getMessage());
        }
        return null;
    }
}