public class Teach extends fflib_SObjectDomain {
    public Teach(List<Teach__c> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<Teach__c> sObjectList) {
            return new Teach(sObjectList);
        }
    }
}