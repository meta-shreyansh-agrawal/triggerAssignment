trigger TeachTrigger on Teach__c (before insert,after insert, before delete, after delete, before update, after update) {
    fflib_SObjectDomain.triggerHandler(Teach.class);
}