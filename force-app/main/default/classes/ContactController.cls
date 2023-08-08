public with sharing class ContactController {
    @AuraEnabled(Cacheable=true)
    public static List<Contact> contactList()
    {
        List<Contact> conList = [SELECT FirstName,LastName,AccountId
                                 FROM Contact];
        return conList;
    }
}