public class FirstWebServiceForOrgToOrg1 {
   
    public static void getContactInfo(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token?grant_type=password&username=pravalikareddy.rangiahgari@mindful-impala-lz6cbg.com&password=reddy@@6303Ncsi1dzx6LDVBb3MKFAH7Doh&client_id=3MVG9pRzvMkjMb6lilgI.qdNF0qphsYafxFYW_YBW62XPfNc0TgFwOJ2joCroDKMSTjjGizeGjBhrCEF94YaJ&client_secret=FD5E34DDB642D42D4C89CFE34F3CBF8DB95252BCD139A6C747E4180E4ADFFB38');
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        res=http.send(req);
        System.debug('res.getBody()'+res.getBody());
    }
    public class ouath{
        public String access_token{get;set;}
        public String instance_url{get;set;}
        public String id{get;set;}
        public String token_type{get;set;}
        public String issued_at{get;set;}
        public String signature{get;set;}
        
    }

}