public with sharing class LeadProcessor implements Database.Batchable<SObject> {
    public Database.QueryLocator  start (Database.BatchableContext bc){
        return Database.getQueryLocator(
            'SELECT ID, LeadSource FROM Lead'
        );
    }

    public void execute (Database.BatchableContext bc, List<Lead> scope){
        List<Lead> updatedLeadSource = new List<Lead>();
        for(Lead l: scope){
            l.LeadSource = 'Dreamforce';
        }
        update updatedLeadSource;
    }

    public void finish(Database.BatchableContext bc){
        system.debug('Done');
    }
}