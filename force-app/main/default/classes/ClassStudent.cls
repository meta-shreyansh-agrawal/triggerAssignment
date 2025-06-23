public with sharing class ClassStudent {
    public static List<String> getStudents(String classId){
		List<Student__c> students = [SELECT First_Name__c,Last_Name__c from student__c where class__r.name =:classId];
        List<String> names = new List<String>(); 
        for(Student__c student: students){
            String name = student.First_Name__c+' '+student.Last_Name__c;
            System.debug(student.First_Name__c+' '+student.Last_Name__c);
        }
        return names; 
	}

    public static Map<String,Set<Id>> getStudentsId(){
        List<Student__c> students = [SELECT Id FROM student__c]; 
        Map<String,Set<Id>> mapStudent = new Map<String,Set<Id>>(); 
        for(Student__c student: students){
            Set<Id> classId = mapStudent.get(student.class__r.Id); 
            if(classId != null){
                classId.add(student.Id); 
            }else{
                classId = new Set<Id>(); 
                classId.add(student.Id);
            }
        }
        return mapStudent;  
    }
}