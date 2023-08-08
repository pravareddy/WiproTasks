@isTest
public class AccountProcessorTest {
    
@isTest static void testAccProcessorMethod()
{
   Schema.Account acc = new Schema.Account();
    acc.Name='acc Testing';
    insert acc;
    Contact con = new Contact();
    con.LastName = 'reddy';
    con.accountId = acc.Id;
    insert con;
    Test.startTest();
        AccountProcessor.countContacts(acc.Id);
    Test.stopTest();
    Schema.Account a =[SELECT Id,Number_Of_Contacts__c
                       FROM Account
                       WHERE Id = : acc.Id];
    System.assertEquals(a.Number_Of_Contacts__c, 1);
    
}
}