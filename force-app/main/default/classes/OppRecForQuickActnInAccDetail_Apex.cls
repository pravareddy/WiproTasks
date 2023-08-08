public with sharing class OppRecForQuickActnInAccDetail_Apex {


    @AuraEnabled(cacheable=true)
    public static List<Schema.Account> getAccRec(Id recId){
       List<Schema.Account> accList = [SELECT Id, Account.Name, Owner.Name
                                       FROM Account
                                       WHERE Id =:recId];
     System.debug('accList>>>>>>>'+accList);
     return accList;

    }

    @AuraEnabled
    public static void saveOppRecords(String Name1,Date CloseDate1,String StageName1,Id recId){
        System.debug('recId>>>>>>>>>>>'+recId);


        Opportunity opp = new Opportunity();
        opp.Name = Name1;
        opp.AccountId = recId;
        opp.CloseDate = CloseDate1;
        opp.StageName = StageName1;
    
        List<Opportunity> oppList = new List<Opportunity>();
        oppList.add(opp);
        //oppList.add(accRecordsApex);
        System.debug('opp>>>>>>>>>>>>>>'+opp);
        //System.debug('accRecordsApex>>>>>>>>>>>>>'+accRecordsApex);
        System.debug('oppList>>>>>>>>'+oppList);
        insert oppList;

       
    }
}