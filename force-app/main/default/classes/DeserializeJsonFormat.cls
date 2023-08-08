public with sharing class DeserializeJsonFormat {
    @AuraEnabled(Cacheable=true)
   public static  Map<String,Object> deserializeJson()
   {
     String JsonString ='{"data":{"orders":[{ "FirstName" : "Pravalika","Object" : "Contact"},{ "FirstName" : "akshu","Object" : "Contact"}]}}';
    Map<String,Object> rawObj = (Map<String,Object>) JSON.deserializeUntyped(JsonString);
   // "ContactList" : [ { "FirstName" : "Pravalika","LastName" : "reddy","Phone" : "(785) 241-6200"},{ "FirstName" : "akshu","LastName" : "milky", "Phone" : "(785) 241-6200" },{ "FirstName" : "Rushi","LastName" : "Young", "Phone" : "(785) 241-6200"},{ "FirstName" : "sana", "LastName" : "Yawn", "Phone" : "(785) 241-6200"}];
      System.debug('rawObj>>>>.'+rawObj);
       return rawObj;
    }




/* HttpRequest req = new HttpRequest();
Http http = new Http();
HTTPResponse res;
try{
	req.setEndPoint('www.salesforce.com');
	req.setMethod('GET');
	res = http.send(req);
	String s = res.getBody();
	JSONParser parser = JSON.createParser(s);
	while (parser.nextToken() != null) {
		if(parser.getCurrentToken() == JSONToken.FIELD_NAME)
			System.debug(parser.getCurrentName());
		else{
			System.debug(parser.getText());
		}
	}
}
catch(Exception e)
{}
   } */
}