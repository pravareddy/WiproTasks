@isTest
public class appendApplication1ToAllBatch_Test {
    static testMethod void testMethod1()
    {
        try{
        Map<String, Application1__c> strToApp1InMap = new Map<String, Application1__c>();
        for(integer i=0;i<=150;i++)
        {
            Application1__c app1 = new Application1__c();
            app1.Name='Test Application'+i;
            strToApp1InMap.put(app1.Name, app1);
        }
        insert strToApp1InMap.values();
         List<Questionnaires__c> questList = new List<Questionnaires__c>();
            for(integer i=0;i<=150;i++)
        {
            Questionnaires__c questObj = new Questionnaires__c();
            questObj.Name='Test Questionaies'+i;
            questObj.Application1Name__c = strToApp1InMap.get(questObj.Application1Id__c).Id;
            questList.add(questObj);
        }
        insert questList;
        Test.startTest();

            appendApplication1ToAll_Batch batchObj = new appendApplication1ToAll_Batch();
            DataBase.executeBatch(batchObj); 
            
        Test.stopTest();
            } catch(DMLException e) {
                System.debug('Ex '+e.getMessage() + ' Line: '+ e.getLineNumber());
            }
    }

}