public with sharing class DisplayRelatedAccInSearchBar {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accName){
        System.debug('DisplayRelatedAccInSearchBar');
        System.debug('accName>>>>>>>>'+accName);
        List<Contact> conList=[SELECT Id, FirstName , LastName, Phone, Email
                               FROM Contact
                               Where Account.Name=:accName];
        System.debug('conList>>>>>>>>>>'+conList);
        return conList;                 
        
    }
}