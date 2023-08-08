public with sharing class displayAccRecInTableToViewInPopUp {
    @AuraEnabled(Cacheable=true)
    public static List<Schema.Account> getAccounts()
    {
        List<Schema.Account> accList = [SELECT Id, Name, Phone, Rating, Industry, Active__c
                                       FROM Account];
        System.debug('accList>>>>>>>>>>>>>'+accList);
        System.debug('Modal Pop Up');
        return accList;
    }
    @AuraEnabled
    public static Schema.Account getSingleAccount(Id accId)
    {
        System.debug('accId>>>>>>>>>>>'+accId);
        Schema.Account AccRecs = [SELECT Id, Name, Phone, Rating, Industry, Active__c
                                  FROM Account
                                  WHERE Id=:accId];
        System.debug('AccRecs>>>>>>>>>>>>>'+AccRecs);
        return AccRecs;
    }
}