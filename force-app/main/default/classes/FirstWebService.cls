@RestResource(urlMapping='/getAccountInfo/*')
global class FirstWebService {
  
    @HttpGet
global static Schema.Account getContact()
{
   RestRequest req = RestContext.request; 
   RestResponse res = RestContext.response;
    String urlId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
    Schema.Account acc = [SELECT Name, Phone
                 FROM Account
                 WHERE Id=:urlId];
    return acc;
}

}