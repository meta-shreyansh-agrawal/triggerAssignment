public without sharing class AddPrimaryContact implements Queueable {
    private Contact contact; 
    private String state;
    public AddPrimaryContact(Contact c, String temp){
        this.contact = c; 
        this.state = temp; 
    }
    
    public void execute(QueueableContext context){
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState =:state LIMIT 200];
        List<Contact> contacts = new List<Contact>();
        
        for(Account acc: accounts){
            Contact contactClone = contact.clone(); 
            contactClone.AccountId = acc.Id; 
            contacts.add(contactClone); 
        }
        insert contacts; 
            
    }
}