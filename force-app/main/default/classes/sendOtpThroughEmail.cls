public with sharing class sendOtpThroughEmail {
    @AuraEnabled(cacheable=true)
    public static void sendOtpByEmail(String userEmail, string otp){
    System.debug('Hi apex class');
    System.debug('userEmail>>>>>>>>>>>>>>>>>'+userEmail);
    System.debug('otp>>>>>>>>>>>>>>>>>>>>'+otp);
    List < Messaging.SingleEmailMessage > mails = new List < Messaging.SingleEmailMessage > ();
    //System.debug('OTP ' + mbody);
    // Step 1: Create a new Email
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    // Step 2: Set list of people who should get the email
    List < String > sendTo = new List < String > ();
    sendTo.add(userEmail);
    mail.setToAddresses(sendTo);
    // Step 3: Set who the email is sent from
    mail.setReplyTo('noreply@gmail.com'); // change it with your mail address.
    mail.setSenderDisplayName('salesforce User');
    // Step 4. Set email contents - you can use variables!
    String Subject = ' Here your one-time code';
    String mbody ='Hi your one time code is'+otp; 
    mail.setSubject(Subject);
    mail.setHtmlBody(mbody);
    // Step 5. Add your email to the master list
    mails.add(mail);
    // Step 6: Send all emails in the master list
    Messaging.sendEmail(mails);

    }
}