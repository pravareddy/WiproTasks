public with sharing class fetchAllRelatedRecords {
    @AuraEnabled(cacheable=true)
    public static List<Contact> retrieveContact(string keySearch){
      System.debug('keySearch>>>>>>'+keySearch);  
    List<Contact> mycontactList = [SELECT Id, FirstName, LastName, Email, Phone, Account.Name 
                                  FROM Contact 
                                  WHERE Account.Name=:keySearch];
    System.debug('mycontactList>>>>>>'+mycontactList);
    return mycontactList;
    }
}