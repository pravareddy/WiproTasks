/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @author         Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @modifiedBy     Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @maintainedBy   Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @version        57.0
* @created        2023-04-26
* @modified      
* @ClassName    appendApplication1ToAll_Batch   
*  **/
public class appendApplication1ToAll_Batch implements Database.Batchable<sObject> {
    Map<String, MortgageKafka__c> successIdsOfKafkaInMap = new Map<String, MortgageKafka__c>();
    Map<String, MortgageKafka__c> failureIdsOfKafkaInMap = new Map<String, MortgageKafka__c>();
  
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query ='SELECT Id,Name FROM Application1__c';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<Application1__c> applicationList){
        System.debug('applicationList>>>>>>>'+applicationList);
        Map<String, Application1__c> appObjByAppName = new Map<String, Application1__c>();
        
        for(Application1__c appObj:applicationList)
        {
            appObjByAppName.put(appObj.Name, appObj); 
        }
        if(!appObjByAppName.isEmpty()){
            updateQuestAppName(appObjByAppName);
            updateCuAddAppName(appObjByAppName);
            updateApplicantAppName(appObjByAppName);
        }
        
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
    public static void updateQuestAppName(Map<String, Application1__c> appObjByAppName){
        List<Questionnaires__c> questObjList = new List<Questionnaires__c>();
        try{
            for(Questionnaires__c questObj : [SELECT Id, Name, Application1Name__c ,Application1Id__c
                                              FROM Questionnaires__c
                                              WHERE Application1Id__c IN:appObjByAppName.keySet()])
            {
                if(appObjByAppName.containsKey(questObj.Application1Id__c) && appObjByAppName.get(questObj.Application1Id__c)!=null)
                {
                    questObj.Application1Name__c =appObjByAppName.get(questObj.Application1Id__c).Id; 
                }
                questObjList.add(questObj);
            }
            if(!questObjList.isEmpty())
            {
                updateSobject(questObjList) ;
            }
            System.debug('questObjList>>>>>>>>>>>>>>'+questObjList);
        }catch(exception e){
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        }  
    }
    public static void updateCuAddAppName(Map<String, Application1__c> appObjByAppName){
        List<CurrentAddress__c> cuAddObjList = [SELECT Id, Name, Application1Id__c
                                              FROM CurrentAddress__c
                                              WHERE Application1Id__c In:appObjByAppName.keySet()];
        try{
            for(CurrentAddress__c cuAddObj :cuAddObjList )
            {
                System.debug('cuAddObj>>>>>>>>>>'+cuAddObj);
                
                if(appObjByAppName.containsKey(cuAddObj.Application1Id__c) && appObjByAppName.get(cuAddObj.Application1Id__c)!=null)
                {
                    cuAddObj.Application1Name__c =appObjByAppName.get(cuAddObj.Application1Id__c).Id; 
                }
                //cuAddObjList.add(cuAddObj);
            }
            if(!cuAddObjList.isEmpty())
            {
                updateSobject(cuAddObjList);
            }
            System.debug('cuAddObjList>>>>>>>>'+cuAddObjList.size());
        }catch(exception e){
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        }  
    } 
    public static void updateApplicantAppName(Map<String, Application1__c> appObjByAppName){
        List<Applicants__c> appObjList = new List<Applicants__c>(); 
        try{
            for(Applicants__c appObj : [SELECT Id, Name, Application1Name__c ,Application1Id__c
                                              FROM Applicants__c
                                              WHERE Application1Id__c IN:appObjByAppName.keySet()])
                
            {
                System.debug('appObj>>>>>>>>>>'+appObj);
                if(appObjByAppName.containsKey(appObj.Application1Id__c) && appObjByAppName.get(appObj.Application1Id__c)!=null)
                {
                    appObj.Application1Name__c =appObjByAppName.get(appObj.Application1Id__c).Id; 
                    System.debug('appObj.Application1Name__c>>>>>>>>>>>>>'+appObj.Application1Name__c);
                }
                appObjList.add(appObj);
                System.debug('appObjList>>>>>>>>>>>>'+appObjList);
            }
            if(!appObjList.isEmpty())
            {
                updateSobject(appObjList);
            }
            System.debug('appObjList>>>>>>>>'+appObjList);
        }catch(exception e){
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        }  
    }
    public static void updateSobject(List<sObject> sObjList){
        try
        {
            Database.SaveResult[] srList = Database.update(sObjList, true);
            
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted objects.  ID: ' + sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                }
            }
        }catch(DmlException e){
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        }    
    }
}