/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @author         Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @modifiedBy     Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @maintainedBy   Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @version        56.0
* @created        2023-04-19
* @modified      
* @className    MortgageKafkaTrigger_Handler Class
*  **/

public with sharing class MortgageKafkaTrigger_Handler {
    
     public static void beforeInsert(List<MortgageKafka__c> mortKafkaList)
    {
        System.debug('mortKafkaMapInBeforeInsert>>>>>>>>>>>>>'+mortKafkaList);
        parsingKafkaBeforeInsert(mortKafkaList);
    }
       /**
* @description      parsingKafkaBeforeInsert method to parse the JSON and then store the application Name in the field of application1Name in Kafka record
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param            Map<Id, MortgageKafka__c> mortKafkaMap
* @param            To get the JsonString value which is stored in JSON_data__c Field
* @param            MortgageKafka__c Object
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘ 
*  **/
    
    public static void parsingKafkaBeforeInsert(List<MortgageKafka__c> mortKafkaList){
        System.debug('beforeInsert mortKafkaList>>>>>>>>>>>>>>'+mortKafkaList);
       
        try{
            if(Schema.SObjectType.MortgageKafka__c.fields.JSON_data__c.isAccessible()){
                
                for(MortgageKafka__c mortKafka : mortKafkaList)
                {
                    String JsonString =  mortKafka.JSON_data__c;
                    //System.debug('mortKafkaList>>>>>>>>>>>>>'+mortKafkaList.size());
                    MortgageKafkaStructure.Application1 mortKafkaObj = (MortgageKafkaStructure.Application1)JSON.deserializeStrict(JsonString, MortgageKafkaStructure.Application1.class);
                    System.debug('mortKafkaObj.Id.numberLong>>>>>>>>>>>>'+mortKafkaObj.Id.numberLong);
                    //MortgageKafka__c mortkaf = new MortgageKafka__c();
                   mortKafka.Application1Name__c=mortKafkaObj.Id.numberLong;
                   System.debug('beforeInsert mortKafka.Application1Name__c>>>>>>>>>>>>>>>>'+mortKafka.Application1Name__c);
                }
                
            }
             
        }catch(exception e){
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        }   
        
    }
    
    public static void afterInsert(Map<Id, MortgageKafka__c> mortKafkaMap) {
        System.debug('mortKafkaMapInAfterInsert>>>>>>>>>>>>>'+mortKafkaMap);
        parsingKafkaAfterInsert(mortKafkaMap);
    }
    
    /**
* @description      parsingKafka method to parse the JSON and then pass the list of records to parseApplication, parseCurrentAddress, parseQuestionnaires and parseApplicants respective methods.
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param            Map<Id, MortgageKafka__c> mortKafkaMap
* @param            To get the JsonString value which is stored in JSON_data__c Field
* @param            MortgageKafka__c Object
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘ 
*  **/
    
    public static void parsingKafkaAfterInsert(Map<Id, MortgageKafka__c> mortKafkaMap) {
        
        List<MortgageKafkaStructure.Application1> mortKafkaObjList = new  List<MortgageKafkaStructure.Application1>();
        try{
            if(Schema.SObjectType.MortgageKafka__c.fields.JSON_data__c.isAccessible()){
                
                for(MortgageKafka__c mortKafka : mortKafkaMap.values())
                {
                    String JsonString =  mortKafka.JSON_data__c;
                    System.debug('mortKafkaMap.values()>>>>>>>>>>>>>'+mortKafkaMap.values().size());
                    MortgageKafkaStructure.Application1 mortKafkaObj = (MortgageKafkaStructure.Application1)JSON.deserializeStrict(JsonString, MortgageKafkaStructure.Application1.class);
                    
                    mortKafkaObjList.add(mortKafkaObj);
                    System.debug('mortKafkaObj>>>>>>>>>'+mortKafkaObj);
                }
                
                if(!mortKafkaObjList.isEmpty()){
                    parseApplication(mortKafkaObjList);
                    parseCurrentAddress(mortKafkaObjList);
                    parseQuestionnaires(mortKafkaObjList);
                    parseApplicants(mortKafkaObjList);
                }
            }            
        }catch(exception e){
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        }   
    }
    
   
    /**
* @description       parseApplication method to get the Application1__c data from  mortKafkaObjList and to pass Application1__c Object list into the insertSObject method
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param             List<MortgageKafkaStructure.Application1> mortKafkaObjList
* @param             Application1__c Object
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘ 
*  **/
    
    public static void parseApplication(List<MortgageKafkaStructure.Application1> mortKafkaObjList)
    {
        Map<String, Application1__c> strToApp1InMap = new Map<String, Application1__c>();
        try
        {
            if(Schema.SObjectType.Application1__c.isAccessible()){
                
                for(MortgageKafkaStructure.Application1 mortKafkaObj : mortKafkaObjList)
                {
                    //Instance for application1 Object
                    Application1__c app1 = new Application1__c();
                    
                    app1.Name = mortKafkaObj.Id.numberLong;
                    app1.Status__c = mortKafkaObj.status;
                    app1.ApplicationType__c= mortKafkaObj.applicationType;
                    app1.IsActive__c  = mortKafkaObj.isActive;
                    //app1.CreationDateUTC__c =Date.valueOf(mortKafkaObj.creationDateUTC.creatDate);
                    //app1.DmlDateUTC__c= Date.valueOf(mortKafkaObj.dmlDateUTC.dmlDate);
                    System.debug('app1>>>>>>>>>'+app1);
                    strToApp1InMap.put(app1.Name, app1);
                    System.debug('strToApp1InMap>>>>>>>.'+strToApp1InMap);
                }
                if(!strToApp1InMap.isEmpty())
                {
                    if(Schema.SObjectType.Application1__c.isCreateable()){
                        insertSObject(strToApp1InMap);
                    }
                }
            }
        }catch(Exception e)
        {
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        }    
    }
    
    /**
* @description       parseCurrentAddress method get the CurrentAddress__c data from  mortKafkaObjList and to pass CurrentAddress__c Object list into the insertSObject method
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param             List<MortgageKafkaStructure.Application1> mortKafkaObjList
* @param             CurrentAddress__c Object
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘ 
*  **/  
    public static void parseCurrentAddress(List<MortgageKafkaStructure.Application1> mortKafkaObjList)
    {
       
        Map<String, CurrentAddress__c> StrToCurrentAddMap = new Map<String, CurrentAddress__c>();
        try
        {
            if(Schema.SObjectType.CurrentAddress__c.isAccessible()){
                for(MortgageKafkaStructure.Application1 mortKafkaObj : mortKafkaObjList){
                    System.debug('mortKafkaObj.Id.numberLong>>>>>>>>'+mortKafkaObj.Id.numberLong);
                    for(MortgageKafkaStructure.wrapCurrentAddress wrapCurrentAddObj :  mortKafkaObj.CurrentAddress)   
                    {
                        CurrentAddress__c currentAddObj = new CurrentAddress__c();
                        currentAddObj.StreetNumber__c=wrapCurrentAddObj.StreetNumber;
                        currentAddObj.StreetName__c=wrapCurrentAddObj.StreetName;
                        currentAddObj.StreetType__c=wrapCurrentAddObj.StreetType;
                        currentAddObj.City__c = wrapCurrentAddObj.City;
                        currentAddObj.Province__c=wrapCurrentAddObj.Province;
                        currentAddObj.PostalCode__c=wrapCurrentAddObj.PostalCode;
                        currentAddObj.Country__c= wrapCurrentAddObj.Country;
                        currentAddObj.Application1Id__c=mortKafkaObj.Id.numberLong;
                        StrToCurrentAddMap.put(currentAddObj.Application1Id__c, currentAddObj);
                    }
                    
                    System.debug('StrToCurrentAddMap>>>>>>>>>>>>>'+StrToCurrentAddMap);
                    
                }
                if(!StrToCurrentAddMap.isEmpty())
                { 
                    if(Schema.SObjectType.CurrentAddress__c.isCreateable()){
                        insertSObject(StrToCurrentAddMap);  
                    }
                }
            }
        }catch(Exception e)
        {
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        } 
    }
    
    /**
* @description parseQuestionnaires method get the Questionnaires__c data from  mortKafkaObjList and to pass Questionnaires__c Object list into the insertSObject method
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    List<MortgageKafkaStructure.Application1> mortKafkaObjList
* @param    Questionnaires__c Object
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘ 
*  **/    
    public static void parseQuestionnaires(List<MortgageKafkaStructure.Application1> mortKafkaObjList)
    {
        Map<String, Questionnaires__c> strToQuestMap = new Map<String, Questionnaires__c>();
        try
        {
            if(Schema.SObjectType.Questionnaires__c.isAccessible()){
                for(MortgageKafkaStructure.Application1 mortKafkaObj : mortKafkaObjList){
                    //Instance for Questionaries Object
                    for(MortgageKafkaStructure.wrapQuestionnaires wrapQuestObj : mortKafkaObj.Questionnaires)
                    { 
                       Questionnaires__c questObj = new Questionnaires__c();
                        questObj.Id__c=wrapQuestObj.Id;
                        questObj.Status__c=wrapQuestObj.Status;
                        questObj.Type__c=wrapQuestObj.Type;
                        questObj.URL__c=wrapQuestObj.Url;
                        questObj.Application1Id__c=mortKafkaObj.Id.numberLong;
                        strToQuestMap.put(questObj.Application1Id__c, questObj);
                        
                    }
                    
                    System.debug('strToQuestMap>>>>>>>>>>>>>'+strToQuestMap);
                    
                }
                if(!strToQuestMap.isEmpty())
                {
                    if(Schema.SObjectType.Questionnaires__c.isCreateable()){
                        insertSObject(strToQuestMap);
                    }
                }
            }
        }catch(Exception e)
        {
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        }
    }
    
    /**
* @description          parseApplicants method get the Applicants__c data from  mortKafkaObjList and to pass Applicants__c Object list into the insertSObject method
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param                List<MortgageKafkaStructure.Application1> mortKafkaObjList
* @param                Applicants__c Object
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘ 
*  **/    
    public static void parseApplicants(List<MortgageKafkaStructure.Application1> mortKafkaObjList)
    {
        Map<String, Applicants__c> strToApplicantsInMap = new Map<String, Applicants__c>();
        try
        {
            if(Schema.SObjectType.Applicants__c.isAccessible()){
                for(MortgageKafkaStructure.Application1 mortKafkaObj : mortKafkaObjList){
                    System.debug('mortKafkaObjList>>>>>>>>>'+mortKafkaObjList);
                    System.debug('mortKafkaObj>>>>>>>>>'+mortKafkaObj);
                    for(MortgageKafkaStructure.wrapApplicant wrapAppl : mortKafkaObj.Applicants)
                    {
                       Applicants__c appl = new Applicants__c();

                        appl.Id__c = wrapAppl.Id;
                        appl.Type__c=wrapAppl.Type;
                        appl.Phone__c = wrapAppl.Phone;
                        appl.Email__c = wrapAppl.Email;
                        appl.MaritalStatus__c = wrapAppl.MaritalStatus;
                        //app1.Dob__c = wrapAppl.Dob;
                        appl.LanguagePreference__c = wrapAppl.LanguagePreference;
                        appl.First_Name__c = wrapAppl.Name.firstName;
                        appl.Last_Name__c = wrapAppl.Name.lastName;
                        appl.Application1Id__c=mortKafkaObj.Id.numberLong;
                        //appl.Dob__c	 = FORMATDATETIME(wrapAppl.Dob.dobDate);
                        strToApplicantsInMap.put(appl.Application1Id__c, appl);
                    }
                    
                    System.debug('strToApplicantsInMap>>>>>>>>>>>>>'+strToApplicantsInMap);
                    
                }
                if(!strToApplicantsInMap.isEmpty())
                { 
                    if(Schema.SObjectType.Applicants__c.isCreateable()){
                        insertSObject(strToApplicantsInMap);
                    }
                }
            }
        }catch(Exception e)
        {
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
        }
    }
    
    public static void insertSObject(Map<String, sObject> sObjMap)
    {
        Set<String> appNamesSet = new Set<String>();
        Map<String,String>  errorMsgByAppName = new Map<String,String>();
        List<String> appNameList = new List<String>();
        Map<String, String> exceptionMsgByAppName = new Map<String,String>();
        String appNameForException;
        System.debug('appNameList>>>>>>>>>>>>>'+appNameList);
        try
        { 
            Database.SaveResult[] srList ;
            for(String str:sObjMap.keySet())
        {
           appNameList.add(str);  
            appNameForException = str;
            srList = Database.insert(sObjMap.values(), true);
            
        }
               
               System.debug('srList>>>>>>>>>>>>>'+srList);
            for(Integer i=0;i<srList.size();i++)
            {
                Database.SaveResult sr = srList[i];
                 if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted objects.  ID: ' + sr.getId());
                    appNamesSet.add(appNameList[i]);
                }
                else {
                    // Operation failed, so get all errors
                    String errorMessage;
                    for(Database.Error err : sr.getErrors()) {
                        errorMessage = 'Insert Failed due to '+err.getStatusCode() + ': ' + err.getMessage()+' for '+err.getFields();
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                        errorMsgByAppName.put(appNameList[i],errorMessage);
                       
                    }
                    System.debug('errorMsgByAppName>>>>>>>>>>>>.'+errorMsgByAppName);
                }
            }
            
           
            if(!appNamesSet.isEmpty())
                { 
                        SuccessAppName(appNamesSet);
                 }
            
                
            
            System.debug('appNamesSet>>>>>>>>>>>>'+appNamesSet);

        }catch(DmlException e){
            System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
           exceptionMsgByAppName.put(appNameForException, 'Ex '+e.getMessage());
            System.debug('exceptionMsgByAppName>>>>>>>>>>>>'+exceptionMsgByAppName);
            
        }  
        if(!exceptionMsgByAppName.isEmpty())
        {
           eexceptionrMsgAppNameMethod(exceptionMsgByAppName);
        }
    }
    public static void SuccessAppName(Set<String> appNamesSet)
    {
        System.debug('appNamesSet>>>>>>>>>>>>>>>'+appNamesSet);
        List<MortgageKafka__c> mortKafkaList1 = [SELECT Id,Name,Processed__c,Status__c,Application1Name__c
                                                FROM MortgageKafka__c
                                                 WHERE Application1Name__c IN: appNamesSet];
        List<MortgageKafka__c> mortKafkaList2 = new List<MortgageKafka__c>();
        if(!appNamesSet.isEmpty())
        {
            for(MortgageKafka__c mortKafka:mortKafkaList1){
                MortgageKafka__c mortObj = new MortgageKafka__c();
                mortObj.Id = mortKafka.Id;
                mortObj.Processed__c = true;
                mortKafkaList2.add(mortObj);
            }
            database.update(mortKafkaList2);
    
        }
        
        //System.debug('mortKafka>>>>>>>>>'+mortKafka);
    }
    public static void eexceptionrMsgAppNameMethod(Map<String,String> exceptionMsgByAppName){
        System.debug('exceptionMsgByAppName>>>>>>>>>>..'+exceptionMsgByAppName);
        
        List<MortgageKafka__c> mortKafkaList1 = [SELECT Id,Name,Application1Name__c,Exception__c
                                                FROM MortgageKafka__c
                                                 WHERE Application1Name__c IN: exceptionMsgByAppName.Keyset()];
        System.debug('mortKafkaList1>>>>>>>>..'+mortKafkaList1);
         List<MortgageKafka__c> mortKafkaList2 = new List<MortgageKafka__c>();
        if(!exceptionMsgByAppName.Keyset().isEmpty())
        {
            for(MortgageKafka__c mortKafka:mortKafkaList1){
                MortgageKafka__c mortObj = new MortgageKafka__c();
                mortObj.Id = mortKafka.Id;
                 mortObj.Processed__c = false;
                mortObj.Exception__c =exceptionMsgByAppName.get(mortKafka.Application1Name__c);
                mortKafkaList2.add(mortObj);
            }
            database.update(mortKafkaList2);
    
            
        }
        System.debug('mortKafkaList2>>>>>>>>>>.'+mortKafkaList2);
        
        
    }
    
}