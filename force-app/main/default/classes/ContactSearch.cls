public with sharing class ContactSearch {
    public static List<Contact> searchForContacts(string lastName,string mailingPostalCode) {
        List<Contact> cntct = [Select ID, Name from Contact where LastName =: lastName AND MailingPostalCode =: mailingPostalCode];
        return cntct;
    }
}