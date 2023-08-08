/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @author         Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @modifiedBy     Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @maintainedBy   Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @version        56.0
* @created        2023-04-19
* @modified      
* @ClassName    MortgageKafkaHandler_Test   
*  **/
@isTest
public class MortgageKafkaHandler_Test {
    
    
    @testSetup static  void setUp()
    {
        Profile agentProfile = [SELECT Id 
                                FROM Profile
                                WHERE Name = 'MortgageAgent'];
        System.debug('agentProfile>>>>>>>>>'+agentProfile);
        User agentUser = new User();
        agentUser.FirstName = 'TestAgent';
        agentUser.LastName='User';
        agentUser.Alias = 'Tagent';
        agentUser.ProfileId=agentProfile.Id;
        agentUser.Email = 'testagent@gmail.com';
        agentUser.Username = 'testagenttt@gmail.com';         
        agentUser.TimeZoneSidKey = 'GMT';                
        agentUser.LanguageLocaleKey = 'en_US';                  
        agentUser.EmailEncodingKey = 'UTF-8';                 
        agentUser.LocaleSidKey = 'en_US';                
                           
        System.debug('agentUser>>>>>>>>>>>>'+agentUser);
        insert agentUser;
        
        Profile adminProfile = [SELECT Id 
                                FROM Profile
                                WHERE Name = 'System Administrator'];
        System.debug('adminProfile>>>>>>>>>'+adminProfile);
        User adminUser = new User();
        adminUser.FirstName = 'TestAdmin';
        adminUser.LastName='User';
        adminUser.Alias = 'TAdmin';
        adminUser.ProfileId=adminProfile.Id;
        adminUser.Email = 'TestAdmin@gmail.com';
        adminUser.Username = 'TestAdminnn@gmail.com';
        adminUser.TimeZoneSidKey = 'GMT';                
        adminUser.LanguageLocaleKey = 'en_US';                  
        adminUser.EmailEncodingKey = 'UTF-8';                 
        adminUser.LocaleSidKey = 'en_US';   
        System.debug('adminUser>>>>>>>>>>>>'+adminUser);
        insert adminUser;
        
    }
    static testMethod void testMortKafkaByAgentUser()
    {
        
        User ageuser =[SELECT Id
                       FROM User
                       WHERE FirstName=:'TestAgent'];
        System.runAs(ageuser)
        {
            
            List<MortgageKafka__c> mortKafkaList = new List<MortgageKafka__c>();
            MortgageKafka__c mortKafkaObj = new MortgageKafka__c();   
            mortKafkaObj.Name='TestMortKafka';
            mortKafkaObj.JSON_data__c='{"Id": {"numberLong": "9912682656122880000"},"creationDateUTC": { "creatDate": "14042023" },"dmlDateUTC": { "dmlDate": "17091998"},"isActive": false, "applicationType": "Switch", "status": "in_progress","Applicants": [ { "Id": "30000004", "Type": "Secondary","Name": {"firstName": "rushendra","lastName": "bushan"},"phone": "4165559876","email": "mahi@gmail.com","dob":{ "dobDate": 17091998}, "MaritalStatus": "single","LanguagePreference": "en"}],"currentAddress": [{ "streetNumber": "190", "streetName": "Trading","streetType": "Drive","city": "Hyderabad","province": "ON","postalCode": "M4L16H","country": "India"}],"questionnaires": [{ "Id": "642d7e606267eed0aae0df6b","url": "/mortgages/questionnaires/642d7e606267eed0aae0df6b","type": "mortgagePrimaryNew", "status": "notStarted"}]}';
            mortKafkaList.add(mortKafkaObj);
            insert mortKafkaList;
            
        }
    }
    
    static testMethod void testMortKafkaByAdminUser()
        
    {
        try{
        User adminUser =[SELECT Id
                         FROM User
                         WHERE FirstName=:'TestAdmin'];
        
        System.runAs(adminUser)
        {
            
            List<MortgageKafka__c> mortKafkaList = new List<MortgageKafka__c>();
            MortgageKafka__c mortKafkaObj = new MortgageKafka__c();   
            mortKafkaObj.Name='TestMortKafka';
            mortKafkaObj.JSON_data__c='{"Id": {"numberLong": "9912682656122880000"},"creationDateUTC": { "creatDate": "14042023" },"dmlDateUTC": { "dmlDate": "17091998"},"isActive": false, "applicationType": "Switch", "status": "in_progress","Applicants": [ { "Id": "30000004", "Type": "Secondary","Name": {"firstName": "rushendra","lastName": "bushan"},"phone": "4165559876","email": "mahi@gmail.com","dob":{ "dobDate": 17091998}, "MaritalStatus": "single","LanguagePreference": "en"}],"currentAddress": [{ "streetNumber": "190", "streetName": "Trading","streetType": "Drive","city": "Hyderabad","province": "ON","postalCode": "M4L16H","country": "India"}],"questionnaires": [{ "Id": "642d7e606267eed0aae0df6b","url": "/mortgages/questionnaires/642d7e606267eed0aae0df6b","type": "mortgagePrimaryNew", "status": "notStarted"}]}';
            mortKafkaList.add(mortKafkaObj);
            insert mortKafkaList;
        } 
        } catch(DMLException e) {
                System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
            }
    }
    @isTest
    static void testDoWorkDMLException(){
        User ageuser =[SELECT Id
                       FROM User
                       WHERE FirstName=:'TestAgent'];
        System.runAs(ageuser)
        {
       }
    }
    
    
}