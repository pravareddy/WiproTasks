public with sharing class UploadContactsByUsingCSVApex {
    @AuraEnabled(cacheable=true)
    public static List<Contact> gettingContacts(String recId)
    {
        System.debug('recId?>>>>>>>>>>'+recId);
        // List<Contact> conList = new List<Contact>();
        List<Contact> con = [SELECT FirstName,LastName,Email,Phone
                       FROM Contact
                       WHERE accountId =: recId];
    //    conList.add(con);
       System.debug('conList?>>>>>>>>>>'+con);
       return con;
      
    }
    @AuraEnabled(cacheable=true)
    
    public static List<Contact> getCSVDownloadLink(String recId)
    {
        try {
            //TODO this should ideally be stored in Custom Settings
           //String contentDocumentId = 'recId';
 
            //Query the ContentDistribution object to retrieve the Downloadable url
            List<Contact> conList = [
                    SELECT Id, FirstName, LastName, Email, phone
                    FROM Contact
                    WHERE accountId =: recId
                    LIMIT 1
                    
            ];
            return conList;
            // if(!contentDistributions.isEmpty() && String.isNotBlank(contentDistributions[0].ContentDownloadUrl))
            // {
            //     return contentDistributions[0].ContentDownloadUrl;
            // }
            // return contentDistributions[0].ContentDownloadUrl;
        }
         catch (Exception e) 
         {
            System.debug('Some excellent error messaging');
         }
      return null;
    }
}