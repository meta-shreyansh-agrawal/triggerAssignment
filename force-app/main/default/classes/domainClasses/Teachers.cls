public class Teachers extends fflib_SObjectDomain {
    public Teachers(List<Contact> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<Contact> sObjectList) {
            return new Teachers(sObjectList);
        }
    }
    public override void onBeforeInsert(){
        blockHindiTeachers();   
    }
    
    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
        blockHindiTeachers();   
    }
    public void blockHindiTeachers(){
        for(Contact con: (List<Contact>)Records){
            if(con.Subjects__c.contains('Hindi')){
                con.addError('We don\'t want Hindi teachers');   
            }
        }   
    }
}