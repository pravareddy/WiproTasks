//Setting up the request URL
@RestResource(urlMapping='/caseApi/*')
global with sharing class createCaseByPostMethod {
    //post method
@HTTPPost
    global static Case createNewCase()
    {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        RestContext.request = req;
        RestContext.response= res;
        try {
        //Intializing the request parameter with the incoming request
        restRequest caseRequest = RestContext.request;
        System.debug('caseRequest>>>>>>>>>>>>>.'+caseRequest);
        //getting request body from the request
        String requestBody = caseRequest.requestBody.toString();
        System.debug('requestBody>>>>>>>>>>>>>>>>>>>>>>>'+requestBody);
        
        //Deserializing the Json response body and assigning it to an instance of case Object
        Case case1 = (Case)Json.deserialize(requestBody, Case.class);
        System.debug('case1>>>>>>>>>>>>>>>>>>>'+case1);
       //Inserting a case    
        insert case1;
        //returning the case in response
        return case1;
        }
        catch(Exception e){
       
               System.debug('The following exception has occurred: ' + e.getMessage());
            return null;
        }
        
    }
    

}