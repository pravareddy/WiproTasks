public with sharing class RetrieveContactsForPromise {
    @AuraEnabled(cacheable=true)
    
    public static List<Contact> getContacts() {
        List<Contact> conList = [SELECT FirstName,LastName,Phone
                                 FROM Contact];  
        System.debug('conList>>>>>>>>>>>'+conList);
        return conList;
    

    }
}