@RestResource(urlMapping='/pravaRestCallPract/*')
global class displayConsRestAPIInWorkbench {
 @HttpGet
 global static List<Contact> doGet()
   {
       RestRequest req = RestContext.request;
       RestResponse res = RestContext.response;
      
       String sAccId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
       List<Contact> objContactInfoList = [SELECT Id,Name,Phone,Email
                                           FROM Contact
                                           WHERE accountId =: sAccId];
      
           return objContactInfoList;
           
      
  }
       

}