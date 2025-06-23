trigger StudentTrigger on Student__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    fflib_SObjectDomain.triggerHandler(Students.class);
}