@isTest
public class createCaseByPost_test {
    @testSetUp 
            static void insertCase(){
            Case cass = new Case(Status='opened', 
                                 Origin='Phone', 
                                 Subject='about Myntra discount');
            insert cass;
    }
    @isTest
           static void testingCase()
           {
               RestRequest req = new RestRequest();
               RestResponse res = new RestResponse();
               req.requestURI ='/services/apexrest/Case/';
               req.httpMethod='POST';
               RestContext.request = req;
               RestContext.response = res;
               String caseId = createCaseByPost.caseInsert('Opened', 'Email', 'system.assertEquals');
               System.debug('caseId>>>>>>>>>>>>>>>>>>>>>'+caseId);
               Case csss = [SELECT Id,Origin, Status, Subject
                            FROM case
                           WHERE Id =: caseId];
               System.assertEquals(csss.Origin,'Email');
               
               
           }

}