public with sharing class AccountController {
    @AuraEnabled(Cacheable=true)
   public static List<Schema.Account> accountList()
   {
   List<Schema.Account> accList = [SELECT Id, Name, Phone, Description, Rating 
                            FROM Account];
    return accList;

   }
}