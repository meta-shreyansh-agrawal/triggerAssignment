public class Classes extends fflib_SObjectDomain {
     public Classes(List<Class__c> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<Class__c> sObjectList) {
            return new Classes(sObjectList);
        }
    }

    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
        List<Class__c> classes = (List<Class__c>)Records; 
        List<Id> classIds = new List<Id>();
        for(Class__c cls: classes){
            if(cls.Custom_Status__c == 'Reset'){
                classIds.add(cls.Id);
            }
        }
        List<Student__c> studentsToDelete = new StudentSelector().selectStudentsByClassIds(classIds);
        StudentService.deleteStudents(studentsToDelete); 
        
    }

    public override void onBeforeDelete(){
       List<Class__c> classes = (List<Class__c>)Records; 
       
       Set<Id> filterIds = new StudentSelector().select_returnsClassIds_whereThereAreMoreThanTwoFemaleStudent_fromClassIds(classes); 
       
       for(Class__c cls: classes){
            if(filterIds.contains(cls.Id)){
                cls.addError('Class cannot be deleted');
            }    
        } 
    }
}