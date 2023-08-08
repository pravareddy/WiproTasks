public with sharing class AccountRelatedContacts {

    @AuraEnabled(cacheable=true)
    public static List<Contact> displayContacts(Id recId){
        System.debug('recId>>>>>>>>>>>>>>.'+recId);
        List<Contact>  connnn= [SELECT FirstName, LastName, Phone, Email, Department
                         FROM Contact
                         WHERE accountId =: recId];
        System.debug('getting contacts from account');
        System.debug('connnn>>>>>>>>>>>>>>'+connnn);
        return connnn;
      
    }
}