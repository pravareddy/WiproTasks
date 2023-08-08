public with sharing class displayAccRelatedConsInTableFormatAura {
   @AuraEnabled(cacheable=true)
   public static List<Contact> getContacts(Id recordId){
    System.debug('recordId>>>>>>>>>>>'+recordId);
    List<Contact> conList =[SELECT Id,FirstName,LastName,Phone,Email,Department
                            FROM Contact
                            WHERE accountId=:recordId];
    System.debug('conList>>>>>>>>>>>'+conList);
    return conList;
   }
}