@isTest
public class createCaseByPostMethod_test {
    @testSetup
    static void testCreatedCase(){
        	Case case2 = new  Case(Priority='Low',
                                   Status='Opened',
                                   Subject='about prasanna hair',
                                   Description='heavy hairfall is started to prasanna..Finally his head became ballHead',
                                   Origin='Phone'
                                   
);
        
        insert case2;
    }
        static testMethod void testPost() {
             Case case33 = [ SELECT Id,Priority ,Status, Subject,Origin,Description 
                            FROM Case 
                            WHERE Subject='about prasanna hair'];
            System.debug('case33>>>>>>>>>>>>>>>>..'+case33);
           
        //RestRequest req = new RestRequest(); 
        //RestResponse res = new RestResponse();             
        //req.requestURI = '/services/apexrest/Case/';
        //req.httpMethod = 'POST';
       // RestContext.request = req;
        //RestContext.response= res;
        //Case caseId = createCaseByPostMethod.createNewCase();
        Test.startTest();
        createCaseByPostMethod.createNewCase();
            
          
        Test.stopTest();
        //Case case33 = [ SELECT Id,Priority ,Status, Subject,Origin,Description FROM Case WHERE Id =: case2.Id ];
        //system.assertEquals(case34.Status, 'Opened');
        //system.assertEquals(case33.Priority, 'Low');
    
       
        //System.debug('case2>>>>>>>>>>>>>>>>>>>'+case2);
        //Test.startTest();
        ///createCaseByPostMethod.createNewCase();
        //Test.stopTest();
        //System.assertEquals('Low', case2.Priority);
        
    
    

}
}