@isTest
public class AddPrimaryContactTest {
    @isTest static void testMe()
    {
     List<Schema.Account> accList = new List<Schema.Account>();
        for(integer i=0;i<50;i++)
        {
            accList.add(new Schema.Account(Name='test'+i,BillingState='NY'));
        }
        for(integer j=0;j<50;j++)
        {
            accList.add(new Schema.Account(Name='test'+j,BillingState='CA'));
        }
        insert accList;
        
        
        test.startTest();
        Contact con = new Contact();
        con.FirstName='prolika';
         con.LastName='reddy';
         String State='NA';
        insert con;
        AddPrimaryContact add = new AddPrimaryContact(con,'CA');
        System.enqueueJob(add);
        test.stopTest();
    }
}