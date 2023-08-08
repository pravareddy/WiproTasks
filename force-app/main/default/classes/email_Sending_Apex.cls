public class email_Sending_Apex {
     @AuraEnabled
    public static void getValues(String fromValue1, String email,String cc,String subject,String mailbody){
        system.debug('fromValue1>>>>>>>'+fromValue1);
        system.debug('email>>>>>>'+email);
        system.debug('cc>>>>>'+cc);
        system.debug('subject>>>>>'+fromValue1);
        system.debug('mailbody>>>>>'+mailbody);
       
    }

}