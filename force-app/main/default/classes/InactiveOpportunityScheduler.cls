public with sharing class InactiveOpportunityScheduler implements Schedulable {
    public void execute(SchedulableContext ctx){
        // Getting all opportunities inactive for last 30 days
        List<Opportunity> opps = [
            SELECT Id,Name,LastModifiedDate,Owner.Email
            FROM Opportunity
            WHERE LastModifiedDate <= : System.today().addDays(-30)
         ]; 

         List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
         
         // adding all mails to emails
         for(Opportunity opp:opps){
            if(opp.Owner.Email!=null){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{opp.Owner.Email});
                email.setSubject('Your opportunity is inactive');
                email.setPlainTextBody('Opportunity is inactive for more than 30 days '+opp.Name);
                emails.add(email);
            }
         }


         // Sending all emails
        if(!emails.isEmpty()){
             Messaging.sendEmail(emails);
        }

    }
}