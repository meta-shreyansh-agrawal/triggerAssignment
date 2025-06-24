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

    public override void onAfterInsert(){
        List<Student__c> students = (List<Student__c>) Records;
        incrementClassMyCount(students); 
    }
    public override void onAfterDelete(){
        List<Student__c> students = (List<Student__c>) Records;
        decrementClassMyCount(students); 
    }

    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
        List<Student__c> students = (List<Student__c>) Records;
        decrementClassMyCount((List<Student__c>)existingRecords.values()); 
        incrementClassMyCount(students); 
    }

    public void decrementClassMyCount(List<Student__c> students){
        Set<Id> classIDs = new Set<Id>(); 
        for(Student__c student: students){
            classIDs.add(student.Class__c);
        }
        List<Class__c> classList = new ClassSelector().selectById(classIds); 
        Map<Id,Class__c> classMap = new Map<Id,Class__c>(); 
        for(Class__c cls: classList){
                classMap.put(cls.Id,cls);
        }
        for(Student__c student: students){
            Class__c classOfStudent = classMap.get(student.Class__c);
            classOfStudent.MyCount__c -= 1; 
        }
        update classMap.values(); 
    }

    public void incrementClassMyCount(List<Student__c> students){
        Set<Id> classIDs = new Set<Id>(); 
        for(Student__c student: students){
            classIDs.add(student.Class__c);
        }
        List<Class__c> classList = new ClassSelector().selectById(classIds); 
        Map<Id,Class__c> classMap = new Map<Id,Class__c>(); 
        for(Class__c cls: classList){
                classMap.put(cls.Id,cls);
        }
        for(Student__c student: students){
            Class__c classOfStudent = classMap.get(student.Class__c);
            classOfStudent.MyCount__c += 1; 
        }
        update classMap.values(); 
    }


}