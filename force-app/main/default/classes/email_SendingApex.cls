public with sharing class email_SendingApex {
    @AuraEnabled
    public static void getValues(String fromValue1, String email,String cc,String subject,String mailbody){
        system.debug('fromValue1>>>>>>>'+fromValue1);
        system.debug('email>>>>>>'+email);
        system.debug('cc>>>>>'+cc);
        system.debug('subject>>>>>'+fromValue1);
        system.debug('mailbody>>>>>'+mailbody);
        try{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {fromValue1};
            String[] ccAddresses = new String[] {cc};
            mail.setToAddresses(toAddresses);
            mail.setCcAddresses(ccAddresses);
            mail.setPlainTextBody(mailBody);
            mail.setSubject(subject);
            //mail.setHtmlBody('<h1>'+ body + '</h1>');
            List<Messaging.SingleEmailMessage> allEmail = new List<Messaging.SingleEmailMessage>();
            allEmail.add(mail);
            Messaging.sendEmail(allEmail);  
        }catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
    }
       
    }