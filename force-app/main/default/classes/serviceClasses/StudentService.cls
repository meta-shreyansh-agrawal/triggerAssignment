public with sharing class StudentService {

    public static void deleteStudents(List<Student__c> students){
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[]{
                Student__c.SObjectType
            }
        );
        for(Student__c stud: students){
            uow.registerDeleted(stud); 
        } 
        uow.commitWork();
    }

    public static Set<Id> getUnavaliableClassIdstoRevokeInsertStudent(List<Id> classId){
        Map<Id,Integer> classToStudentCountMap = new StudentSelector().getStudentCountOfClasses(classId);
        List<Class__c> classDetails = new ClassSelector().selectById(new Set<Id>(classId));
        Set<Id> filteredClassIds = new Set<Id>();
        for(Class__c cls: classDetails){
            if(classToStudentCountMap.get(cls.Id)>=cls.Max_Size__c){
                filteredClassIds.add(cls.Id);
            }
        }
        return filteredClassIds;
    }
}