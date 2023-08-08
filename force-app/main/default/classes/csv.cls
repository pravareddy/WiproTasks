public with sharing class csv {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAccountDataToExport(){
        List<Contact> lstContacts = [SELECT Id, FirstName, LastName, Email 
FROM Contact LIMIT 10];
        return lstContacts;
    }
}