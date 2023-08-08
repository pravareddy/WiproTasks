@RestResource(urlMapping='/getContactInfo/*')
global class FirstWebServiceForOrgtoOrg {
    @HTTPGet
    global static Contact getContact()
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String conId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        System.debug('conId>>>>>>>>>>>>>>>>>>>>'+conId);
        Contact con=[SELECT FirstName,LastName,Phone,Email
                     FROM Contact
                      WHERE Id =:conId];
          return con;
        
    }

}