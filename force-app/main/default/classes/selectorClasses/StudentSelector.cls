public with sharing class StudentSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
                Student__c.Id,
                Student__c.Age__c, 
                Student__c.Class__c,
                Student__c.Date_of_Birth__c,
                Student__c.Email__c,
                Student__c.First_Name__c,
                Student__c.Last_Name__c,
                Student__c.Sex__c,
                Student__c.Married__c,
                Student__c.Name
        };
    }
     public Schema.SObjectType getSObjectType() {
        return Student__c.sObjectType;
    }
    public List<Student__c> selectById(Set<ID> idSet) {
        return (List<Student__c>) selectSObjectsById(idSet);
    }

    public List<Student__c> selectStudentsByClassIds(List<Id> classIds){
        return [SELECT Id FROM Student__c WHERE Class__c in :classIds];
        
        // return (List<Student__c>) Database.query(
        //     newQueryFactory()
        //     .setCondition(' Class__c in :'+ classIds)
        //     .toSOQL()
        // );
    }

    public Map<Id,Integer> getStudentCountOfClasses(List<Id> classes){

        List<AggregateResult> result = [SELECT COUNT(Id) studentCount, Class__c FROM Student__c GROUP BY Class__c Having Class__c in : classes ]; 

        // List<AggregateResult> result = Database.query(
        //     newQueryFactory()
        //     .selectField('Count(Id) studentCount')
        //     .selectField('Class__c')
        //     .toSOQL() + 'GROUP BY Class__c HAVING Class__c in :'+classes); 
        Map<Id,Integer> classIdToStudentCountMap = new Map<Id,Integer>();
        for(AggregateResult r: result){
            classIdToStudentCountMap.put((Id)r.get('Class__c'),(Integer)r.get('studentCount'));
        }
        return classIdToStudentCountMap; 
    } 

    public Set<Id> select_returnsClassIds_whereThereAreMoreThanTwoFemaleStudent_fromClassIds(List<Class__c> classes){
        List<AggregateResult> result = Database.query(
            newQueryFactory()
            .selectField('Class__c')
            .selectField('Count(Id) femaleStudentCount')
            .setCondition('Sex__c = \'Female\'')
            .toSOQL() + 'group by class__c having count(Id)>1 and class__c in :'+classes); 
        Set<Id> classIds = new Set<Id>();
        for(AggregateResult r:result){
            classIds.add((Id)r.get('class__c'));
        }
        return classIds; 
    }

}