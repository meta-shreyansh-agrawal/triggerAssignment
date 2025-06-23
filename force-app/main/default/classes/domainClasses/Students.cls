public class Students extends fflib_SObjectDomain {
    public Students(List<Student__c> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<Student__c> sObjectList) {
            return new Students(sObjectList);
        }
    }

    public override void onBeforeInsert(){
        List<Student__c> students = (List<Student__c>) Records; 
        
        // Check if classes have avaliable seats
        List<Id> classIds = new List<Id>();
        for(Student__c student:students){
                classIds.add(student.Class__c);
        }

        Set<Id> filteredClassIds = StudentService.getUnavaliableClassIdstoRevokeInsertStudent(classIds);
        
        for(Student__c student: students){
            if(filteredClassIds.contains(student.Class__c)){
                student.addError('No Seats Available');
            }
        }
    }
}