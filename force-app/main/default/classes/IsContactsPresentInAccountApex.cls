public with sharing class IsContactsPresentInAccountApex {
    @AuraEnabled(cacheable=true)
    
    public static List<Contact> getAllConFromAccount(String recId){
       List<Contact> conObj = new List<Contact>();
      List<Contact> conList=[SELECT FirstName,LastName,Phone,Email,Department
                             FROM Contact
                             WHERE accountId =:recId];
        for(Contact con:conList)
        {
          conObj.add(con);
        }

       return conObj;
      
    }
}