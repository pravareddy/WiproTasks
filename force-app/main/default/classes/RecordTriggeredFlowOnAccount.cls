public class RecordTriggeredFlowOnAccount {
//List<Opportunity> oppList = new List<Opportunity>();
@InvocableMethod
    public static void createOpportunity(){
        Opportunity opp = new Opportunity();
        opp.DeliveryInstallationStatus__c='In progress';
        
         opp.Probability=70;
          opp.Name='PravalikaOpportunity';	
         opp.StageName='Closed Won';
         opp.CloseDate=Date.newInstance(2024,9,17);
         opp.Description='hiii this one is sample opportunity which was i created';
    
    //oppList.add(opp);
    
    
    
    insert opp;
        System.debug('Record Triggered Flow');
        System.debug('opp>>>>>>>>>>>>>>>>>>>>>>>>>>'+opp);
    }
    
    
}