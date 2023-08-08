@isTest
public with sharing class Test_SendEmail_Apex {
    @testsetup
    static void makeData(){
        EmailTemplate  emailTemp = new EmailTemplate(DeveloperName='pravalikareddyRangiahgari',
                                                     Name = 'test send mail',
                                                     FolderId = Userinfo.getUserId(),
                                                     TemplateType = 'text',
                                                     IsActive = true,
                                                     Subject='Your Free shipping ends soon',
                                                     Body='hii..we hope you are enjoying poshmark! with designer deals at up to 70% off, FREE shipping on your first purchase ends soon!');
        
        insert emailTemp;
        System.debug('emailTemp>>>>>>>>>>>>'+emailTemp);
        
    }
@isTest
static void testContact(){
    
    //inserting a EmailTemplate
   	//inserting a account
    Schema.Account acc = new Schema.Account();
    acc.Name='EmailTemplate';
    acc.Phone='8897475466';
    insert acc;
    System.debug('acc>>>>>>>>>>>>>>'+acc);

    //inserting a contact
  Contact con = new Contact(FirstName='Narasimha',
                            LastName='Reddy',
                            Email='narasimha12@gmail.com',
                            Phone='9912687505',
                            Department='Finance',
                            accountId = acc.Id);
   insert con;
   System.debug('con>>>>>>'+con);

//    Case caseObj = new Case(
//                            Subject='testing emailTemplate',
//                            Description='how we have to test email template means...',
//                            ContactId = con.Id);  
//    insert caseObj;

	EmailTemplate emailTemp1 = [SELECT Id, Name, DeveloperName, FolderId, TemplateType, Description, Subject, Body 
                                FROM EmailTemplate 
                                WHERE Name = 'test send mail'];
    System.debug('emailTemp1>>>>>>>>>>>>>.'+emailTemp1);
   if(emailTemp1 != null)
   {
    Test.startTest();
    SendEmail_Apex.getContacts(con.accountId);
    SendEmail_Apex.getValues_EmailTemplate();
    //SendEmail_Apex.getIdFromEmailTemp(emailTemp1.Id);
    SendEmail_Apex.getLastName(con.LastName);
    SendEmail_Apex.sendEmail(emailTemp1.Subject, emailTemp1.Body, con.LastName,emailTemp1.Id);
    SendEmail_Apex.sendEmail2(con.LastName,emailTemp1.Id);
    Test.stopTest();
    System.assertEquals('pravalikareddyRangiahgari', emailTemp1.DeveloperName);
    System.assertEquals('EmailTemplate', acc.Name );
    System.assertEquals('Reddy', con.LastName);
   }

}
}