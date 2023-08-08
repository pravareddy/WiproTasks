@isTest
public class PutMethodForContact_test {
    @testSetUp
             static void insertContact()
             {
                 Contact con = new Contact(FirstName = 'Rangiagari',
                                           LastName = 'Rajasimha',
                                           Phone='91002456777',
                                           Email = 'rajasimha@gmail.com');
                 insert con;
             }
    @isTest
    static void checkContact(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI='/services/apexrest/Contact/';
        req.httpMethod='PUT';
        RestContext.request = req;
        RestContext.response = res;
        String acctId = PutMethodForContact.aboutContact('Rangiagari', 'Rajasimha', '91002456777','rajasimha@gmail.com');
        System.debug('acctId>>>>>>>>>>>>>>'+acctId);
        //Contact con1 = [SELECT FirstName, LastName, Phone, Email
                      // FROM Contact
                       //WHERE accountId =: acctId];
        //System.debug('con1>>>>>>>>>>'+con1);
        //system.assertEquals(con1.FirstName, 'Rangiagari');
        //system.assertEquals(acc.Description, 'Testing');
    }
        
    }