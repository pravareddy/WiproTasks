public class CampaignTriggerHandler {
    public static void getCampaign(){
       // List<Campaign> campgnList = new List<Campaign>();
       List<CampaignMember> cmpMembList = new List<CampaignMember>();
        List<Opportunity> oppList = new List<Opportunity>();
       Map<String,Campaign> stringToCmpMemb = new Map<String,Campaign>();
        List<Campaign> cmpgn=[SELECT Id,Name,NumberOfLeads,NumberOfContacts,Status
                               FROM Campaign];
        System.debug('cmpgn>>>>>>>>>>>>'+cmpgn);
        for(Campaign cmp:cmpgn)
        {
            if( cmp.Status =='In Progress')
            {
                
                //CampaignMember cmpMemb = [SELECT FirstName, LastName, City, CompanyOrAccount, Status
                  //                       FROM CampaignMember
                 //                         wHERE CampaignId =:cmp.Id];
                //System.debug('cmpMemb>>>>>>>>>'+cmpMemb);
                //cmpMembList.add(cmpMemb);
                
                
               
               stringToCmpMemb.put(cmp.Id,cmp);
                
            }
        }
        List<CampaignMember> cmpMemb = [SELECT FirstName, LastName, City, CompanyOrAccount, Status
                                      FROM CampaignMember
                                       wHERE CampaignId =:stringToCmpMemb.keySet()];
        System.debug('cmpMemb>>>>>>'+cmpMemb);
        Map<String,Schema.Account> accMap = new Map<String,Schema.Account>(); //account name and account values
        List<Schema.Account> accList =[SELECT Id,Name
                                       FROM Account];
        for(Schema.Account accObj:accList){
            
            accMap.put(accObj.Name,accObj);
            
        }
        
        
        
        for(CampaignMember cmpObj:cmpMemb)
        {
            System.debug('cmpObj' + cmpObj);
            //if(accMap.get(containsKey()))
            if(accMap.get(cmpObj.CompanyOrAccount).Name == cmpObj.CompanyOrAccount)
            {
                Opportunity opp = new Opportunity();
                opp.AccountId=accMap.get(cmpObj.CompanyOrAccount).Id;
                opp.Name=accMap.get(cmpObj.CompanyOrAccount).Name;
                opp.CloseDate= Date.newInstance(2022,17,9);
                opp.StageName='Closed Won';
                
               oppList.add(opp);
            } 
        }
        
        insert oppList;
        
        
    }

}