public with sharing class ContactsInTableFormatApex {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAllContacts(Id recId){
       // List<Contact> conList = new List<Contact>();
        List<Contact> conList=[SELECT FirstName,LastName,Phone,Email,Department
                       FROM Contact
                       WHERE accountId =:recId];
        
         return conList;

    }
}