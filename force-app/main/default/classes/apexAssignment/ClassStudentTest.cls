@isTest
private class ClassStudentTest {

@IsTest
    static void testGetStudents() {
        // Create a test class record
        Class__c testClass = new Class__c(Name__c = 'TestClass',Fee__c = 1000,Max_Size__c = 100,MyCount__c = 0);
        insert testClass;

        // Create test student records associated with the test class
        Student__c student1 = new Student__c(First_Name__c = 'John', Last_Name__c = 'Doe', Class__c = testClass.Id,Date_of_Birth__c=Date.newInstance(2000, 01, 01),Email__c='ashreyansh@gmail.com');
        Student__c student2 = new Student__c(First_Name__c = 'Jane', Last_Name__c = 'Smith', Class__c = testClass.Id,Date_of_Birth__c=Date.newInstance(2000, 02, 01),Email__c='ashreyansh2@gmail.com');
        insert new List<Student__c>{student1, student2};

        // Call the getStudents method
        List<String> studentNames = ClassStudent.getStudents(testClass.Name__c);

        // Verify the results
        System.assertEquals(2, studentNames.size(), 'Expected 2 student names');
        System.assertEquals('John Doe', studentNames[1], 'First student name mismatch');
        System.assertEquals('Jane Smith', studentNames[0], 'Second student name mismatch');
    }

@IsTest
    static void testGetStudentsId() {
        // Create a test class record
        Class__c testClass = new Class__c(Name__c = 'TestClass',Fee__c = 1000,Max_Size__c = 100,MyCount__c = 0);
        insert testClass;

        // Create test student records associated with the test class
        Student__c student1 = new Student__c(First_Name__c = 'John', Last_Name__c = 'Doe', Class__c = testClass.Id,Date_of_Birth__c=Date.newInstance(2000, 01, 01),Email__c='ashreyansh@gmail.com');
        Student__c student2 = new Student__c(First_Name__c = 'Jane', Last_Name__c = 'Smith', Class__c = testClass.Id,Date_of_Birth__c=Date.newInstance(2000, 02, 01),Email__c='ashreyansh2@gmail.com');
        insert new List<Student__c>{student1, student2};

        // Call the getStudentsId method
        Map<Id, Set<Id>> classToStudentMap = ClassStudent.getStudentsId();

        // Verify the results
        System.assertEquals(1, classToStudentMap.size(), 'Expected 1 class in the map');
        System.assert(classToStudentMap.containsKey(testClass.Id), 'Map should contain the test class Id');
        Set<Id> studentIds = classToStudentMap.get(testClass.Id);
        System.assertEquals(2, studentIds.size(), 'Expected 2 student Ids for the test class');
        System.assert(studentIds.contains(student1.Id), 'Map should contain student1 Id');
        System.assert(studentIds.contains(student2.Id), 'Map should contain student2 Id');
    }
}