public class SecurityEnforcedApex {
    public static void displayFields()
    {
       List<Account> accList = [SELECT Id,Name,Active__c,Phone,Total_Percentage__c
                                 From Account
                                 WITH SECURITY_ENFORCED
                                 ];
                                 
        System.debug('accList>>>>>'+accList);
        
        //Systen.debug('accList>>>>>'+accList);
       /*Account accList1 = [SELECT Id,Total_Percentage__c
                           FROM Account
                           WHERE Name Like 'Burlington Textiles Corp of America' 
                           with SECURITY_ENFORCED];
          System.debug('accList1>>>>>>'+accList1); */

    }
    

}