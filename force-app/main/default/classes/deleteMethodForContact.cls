@RestResource(urlMapping='/deleteContact/*')
global class deleteMethodForContact {
    @HTTPDelete
    
global static void deleteContact()
{
    RestRequest req = RestContext.request;
    String memberId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
    System.debug('memberId>>>>>>>>>>>>>>>>.'+memberId);
    List<Schema.Account> acc = [SELECT Id,Name
                         FROM Account
                         WHERE Id =:memberId];
    delete acc;
}
}