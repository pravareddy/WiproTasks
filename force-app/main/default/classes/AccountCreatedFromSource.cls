public class AccountCreatedFromSource {
    public class deserializeResponse{

        public String id;

        public String access_token;

    }

    @future(callout=true)

    public static void createAccountinTargetOrg(String accName, String accId){ 

        String clientId = '3MVG9n_HvETGhr3D4YN_dM.qWLFBoFMnkstytQfbZCcuJXFP_ium0fHtr4G6DxzfUGh8xe6UNGUUUYJzB61u6';//your consumer Key

        String clientSecret = '23335A2B5BB7E3D4A09A96FFA54E0B6048D3C07B4F2DBEC6D4CB6616304213A3';//your consumer secret

        String username = 'pravalikareddy.rangiahgari@empathetic-unicorn-2r1b4g.com';

        String password ='Women@@6303';

        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;

        Http h = new Http();

        HttpRequest req = new HttpRequest();

        req.setBody(reqbody);

        req.setMethod('POST');

       req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        System.debug('h>>>>>>>>>>>>'+h);
        System.debug('req>>>>>>>>>>>>'+req);
        
        HttpResponse res = h.send(req);
        System.debug('res>>>>>>>>>>>>'+res);

        deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
        System.debug('resp1>>>>>>>>>>>>'+resp1);

        if(resp1.access_token != null){

            String endPoint = 'https://login.salesforce.com/services/apexrest/createAccount/';

            String jsonstr = '{"AccName" : "' + accName + '"}';

            Http h2 = new Http();

            HttpRequest req1 = new HttpRequest();
            System.debug('h2>>>>>>>>>>>>'+h2);
           

            req1.setHeader('Authorization','Bearer ' + resp1.access_token);

            req1.setHeader('Content-Type','application/json');

            req1.setHeader('accept','application/json');

            req1.setBody(jsonstr);

            req1.setMethod('POST');

            req1.setEndpoint(endPoint);
             System.debug('req1>>>>>>>>>>>>'+req1);

            HttpResponse res1 = h2.send(req1);
             System.debug('res1>>>>>>>>>>>>'+res1);

        }

    }

}