public with sharing class EmailSending_Apex {
   @AuraEnabled
   public static List<Contact> gettingEmail(String toAddress){
       System.debug('toAddress>>>>>>>>>>>>>>>'+toAddress);
       List<Contact> conListt = [SELECT FirstName,LastName,Phone,Id
                      FROM Contact
                      WHERE Email=:toAddress];
        System.debug('conListt>>>>>>>>>>>'+conListt);
       return conListt;
      
   }
}