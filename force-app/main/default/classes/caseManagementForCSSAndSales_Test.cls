/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @author         Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @modifiedBy     Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @maintainedBy   Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @version        58.0
* @created        2023-06-26
* @modified      
* @ClassName    caseManagementForCSSAndSales_Test   
*  **/
@isTest
public class caseManagementForCSSAndSales_Test {
    
    @testSetup static void setUpMethod()
    {
        //Map<Id,Case> caseObjById = new Map<Id,Case>();
        List<Case> caseList = new List<Case>();
        List<Case> updatedCaseList = new List<Case>();
        // List<CaseHistory> caseHistoryList = new List<CaseHistory>();
        // 
        
        Profile profileObj = [SELECT Id 
                              FROM Profile
                              WHERE Name = 'System Administrator'];
        System.debug('profileObj>>>>>>>>>'+profileObj);
        User userObj = new User();
        userObj.FirstName = 'TestForCase';
        userObj.LastName='User';
        userObj.Alias = 'TestCase';
        userObj.ProfileId=profileObj.Id;
        userObj.Email = 'TestAdmin@gmail.com';
        userObj.Username = 'TestAdminnn@gmail.com';
        userObj.TimeZoneSidKey = 'GMT';                
        userObj.LanguageLocaleKey = 'en_US';                  
        userObj.EmailEncodingKey = 'UTF-8';                 
        userObj.LocaleSidKey = 'en_US';   
        System.debug('userObj>>>>>>>>>>>>'+userObj);
        insert userObj;
        
        for(integer i=1;i<=10;i++)
        {
            Case caseObj = new Case();
            caseObj.Status = 'new';
            caseObj.Origin='Phone';
            caseObj.ownerId = userObj.Id;
            if( i / 2 == 0){
                caseObj.Subject='Sales Case'+i;
                caseObj.Working_Team__c='Sales';
            }else{
                caseObj.Subject='CSS Case'+i;   
                caseObj.Working_Team__c='CSS';   
            }
            caseList.add(caseObj);
        }
        insert caseList;
        
         
       CaseHistory caseHistoryObj = new CaseHistory(Field ='Owner',DataType='EntityId',caseId = caseList[0].Id);
       insert caseHistoryObj;
    }
    
    static testMethod void TestCSSCase()
    {
        List<List<Case>> caseListOfList = new List<List<Case>>();
        List<Case> caseList1 = [SELECT Id, Status, Origin, Subject, Working_Team__c,OwnerId,CreatedDate
                                FROM Case
                                WHERE Status='new'
                                OR Working_Team__c='CSS'];
        caseListOfList.add(caseList1);
        System.debug('caseList1>>>>>>>>>>>>>'+caseList1);
        
        Test.startTest();
        caseManagementForCSSAndSales.updateFieldsInCase(caseListOfList);
        Test.stopTest();
        //System.assertEquals(expected, actual);
        
    }
    
    static testMethod void TestSalesCase()
    {
        List<List<Case>> caseListOfList = new List<List<Case>>();
        List<Case> caseList1 = [SELECT Id, Status, Origin, Subject, Working_Team__c,OwnerId,CreatedDate
                                FROM Case
                                WHERE Status='new'
                                OR Working_Team__c='Sales'];
        caseListOfList.add(caseList1);
        System.debug('caseList1>>>>>>>>>>>>>'+caseList1);
        
        Test.startTest();
        caseManagementForCSSAndSales.updateFieldsInCase(caseListOfList);
        Test.stopTest();
        
    }
    
}