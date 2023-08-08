public with sharing class storeRecordsInCaseObjectAura {
    @AuraEnabled
   
   public static void storingRecInCase(String Subject, String SuppliedCompany,String SuppliedName,String field)
   {
       System.debug('Subject>>>>>>>>>>>>>>>>>>>>>.'+Subject);
       System.debug('SuppliedCompany>>>>>>>>>>>>>>>>>>>>>.'+SuppliedCompany);
       System.debug('SuppliedName>>>>>>>>>>>>>>>>>>>>>.'+SuppliedName);
       System.debug('field>>>>>>>>>>>>>>>>>>>>>.'+field);
       Case caseObj = new Case();
       caseObj.Subject=Subject;
       caseObj.SuppliedCompany=SuppliedCompany;
       caseObj.SuppliedName=SuppliedName;
       caseObj.Comments=field;
       insert caseObj;
       System.debug('hii getting records from aura');
       System.debug('caseObj>>>>>>>>>>>>>>'+caseObj);

   }
}