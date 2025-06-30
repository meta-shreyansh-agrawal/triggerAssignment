public with sharing class ClassStudent {
    public static List<String> getStudents(String classId){
		List<Student__c> students = [SELECT First_Name__c,Last_Name__c,Class__c from student__c where Class__r.Name__c =:classId];
        List<String> names = new List<String>(); 
        for(Student__c student: students){
            String name = student.First_Name__c+' '+student.Last_Name__c;
            names.add(name); 
            System.debug(student.First_Name__c+' '+student.Last_Name__c);
        }
        return names; 
	}

    public static Map<Id,Set<Id>> getStudentsId(){
        List<Student__c> students = [SELECT Id,class__r.Id FROM student__c]; 
        Map<Id,Set<Id>> mapStudent = new Map<Id,Set<Id>>(); 
        for(Student__c student: students){
            Set<Id> classId = mapStudent.get(student.class__r.Id); 
            //System.debug(student.class__r.Id +'->'+student.Id); 
            if(classId != null){
                classId.add(student.Id); 
            }else{
                classId = new Set<Id>(); 
                classId.add(student.Id);
                mapStudent.put(student.class__r.Id,classId); 
            }
        }
        return mapStudent;  
    }
}