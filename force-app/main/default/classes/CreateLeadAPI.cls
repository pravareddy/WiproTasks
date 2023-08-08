@RESTResource(urlMapping='/CreateLead/')
global class CreateLeadAPI {
    @HTTPPost
    global static String CreatingLeadRecord(){
        String Fname,Lname,comp;
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;	
        String jsonBody = req.requestBody.toString();
        System.debug('jsonBody>>>>>>>>>>>>>>'+jsonBody);
        //JSONParser parser= JSON.createParser(jsonBody)
        return null;
    }
    

}