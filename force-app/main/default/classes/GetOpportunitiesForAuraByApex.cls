public with sharing class GetOpportunitiesForAuraByApex {
   public static List<Opportunity> getAllOpportunities()
   {
       List<Opportunity> oppList =[SELECT  CurrentGenerators__c, Name, Amount, ExpectedRevenue
                                     FROM Opportunity];
       System.debug('oppList>>>>>>'+oppList);
       return oppList;

   }
}