public with sharing class CustomDataTableApex {
    @AuraEnabled(cacheable=true)
    public static List<Contact> gettingContacts(Id recId)
    {
        
      List<Contact> conList = [SELECT Id,FirstName,LastName,Phone,Email
                               FROM Contact
                               WHERE accountId =: recId]; 
        System.debug('conList>>>>>'+conList);
    
    return conList;
    }
    @AuraEnabled(cacheable=true)
    public static void updatingContacts(List<Contact> conList){
        upsert conList;
    }
      


}