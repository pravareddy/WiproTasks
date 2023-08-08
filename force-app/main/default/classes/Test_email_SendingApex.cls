@isTest
public with sharing class Test_email_SendingApex {
   @isTest static void testThatEmailWasSent() 
   {
   
    String fromValue1 = 'pravalikareddy3663@gmail.com';
    String email = 'pravareddy91333@gmail.com';
    String cc = 'pravareddy91333@gmail.com';
    String subject = 'Working';
    String mailbody = 'Pravalika Reddy';
    //Test.startTest();
       
    email_SendingApex.getValues(fromValue1, email, cc, subject, mailbody);
      
    //Test.stopTest();





    // Test.startTest();
    // System.assertEquals(0, Limits.getEmailInvocations(), 'No emails should be sent');

    // email_SendingApex.getValues();
    // System.assertEquals(1, Limits.getEmailInvocations(), 'Emails should be sent');
    // Test.stopTest();
    // Test.startTest();
    // Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    // String[] toAddresses = new String[] {'pravalikareddy3663@gmail.com'};
    // String[] ccAddresses = new String[] {'pravareddy91333@gmail.com'};
    // mail.setToAddresses(toAddresses);
    // mail.setCcAddresses(ccAddresses);
    // mail.setPlainTextBody('hiiiiiiiiiiiiiiiiii');
    // mail.setSubject('mydetails');
    // //mail.setHtmlBody('<h1>'+ body + '</h1>');
    // List<Messaging.SingleEmailMessage> allEmail = new List<Messaging.SingleEmailMessage>();
    // allEmail.add(mail);
    // Messaging.sendEmail(allEmail); 
    // Test.stopTest();
   }
}