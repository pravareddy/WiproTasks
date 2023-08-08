@isTest
public class deleteMethodForContact_test {
    @isTest
    static void createAccount(){
        Schema.Account acc = [SELECT Id,Name
                      FROM Account
                      LIMIT 1];
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Account/' + acc.Id;
        req.httpMethod='DELETE';
        RestContext.request = req;
        RestContext.response = res;
        deleteMethodForContact.deleteContact();
    
    }

}