trigger OpportunitiesTrigger on Opportunity (before insert,after insert, before delete, after delete, before update, after update) {
        fflib_SObjectDomain.triggerHandler(Opportunities.class);
}