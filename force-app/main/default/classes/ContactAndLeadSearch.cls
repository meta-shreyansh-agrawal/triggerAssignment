public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(string name) {
        List<List<SObject>> temp = [FIND :name IN NAME FIELDS RETURNING CONTACT(FirstName,LastName), LEAD(FirstName,LastName)];
        return temp; 
    }
}