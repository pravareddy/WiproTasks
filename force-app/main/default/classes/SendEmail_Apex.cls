public with sharing class SendEmail_Apex {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id recId)
    {
        List<Contact> conList = [SELECT FirstName,LastName ,Email,Phone
                                 FROM Contact
                                 WHERE accountId =: recId];
        System.debug('sending an Email');
        System.debug('conList>>>>>>>'+conList) ;                               
        return conList;
    }
    @AuraEnabled(cacheable=true)
    
   public static List<EmailTemplate> getValues_EmailTemplate()
   {
    //    String emTemp = '%'+empTemp+'%';
       List<EmailTemplate> emailTemp = [SELECT Id, DeveloperName, Subject, Body
                                        FROM EmailTemplate];
        System.debug('email template');
        System.debug('emailTemp>>>>>>>>>>>'+emailTemp);
        return emailTemp;

   }
  //  @AuraEnabled(cacheable=true)
  //  public static EmailTemplate getIdFromEmailTemp(Id emailTempId)

  //  {
  //     System.debug('emailTempId>>>>>>>>'+emailTempId);
  //     EmailTemplate emTemp = [SELECT Subject, Body
  //                             FROM EmailTemplate
  //                             WHERE Id=:emailTempId];
  //     System.debug('based on Id Fetching data');
  //     System.debug('emTemp>>>>>>>>'+emTemp);
  //     return emTemp;
  //  }
   @AuraEnabled(cacheable=true)
   public static Contact getLastName(String storeLName)

   {
      System.debug('storeLName>>>>>>>>'+storeLName);
                 Contact con = [SELECT Email
                                 FROM Contact
                                 WHERE LastName =:storeLName];
      System.debug('based on LastName Fetching data');
      System.debug('con>>>>>>>>'+con);
       return con;

    }


@AuraEnabled(cacheable=true)
    public static void sendEmail(String Subject1, String Body, String storeLName1, Id templateId){
       
       System.debug('storeLName1>>>>>>>>>>>+storeLName1');
       System.debug('Subject1>>>>>>>>>>>>>>'+Subject1);
       //List<String> emails = new List<String>();
       //System.debug('inside method '+contactSelected);
       //emails.add(contactName(name));
    //    System.debug('name>>>>>>>>>>>>>>>>>'+name);
    //    System.debug('name selected>>>>>>>>'+nameSelected);
    //Contact conEmail = new Contact();
       Contact toEmail = [SELECT Id, Name, Email, Phone, CreatedById, Owner.Name,Owner.Phone, Owner.Email
                          FROM Contact
                          WHERE LastName=: storeLName1 
       ];
       System.debug('toEmail>>>>>>>>>>>>>>>'+toEmail);

      //  Case caseobj = [SELECT Id, CaseNumber, Subject, Description
      //                  FROM Case   
      //                  WHERE ContactId =:toEmail.Id];
      //  System.debug('caseobj>>>>>>.'+caseobj);
      //  User userObj =[SELECT Name, Phone, Email
      //                 FROM User
      //                 WHERE ContactId =:toEmail.Id];
      //  System.debug('userObj>>>>>>.'+userObj);

      //  String str=toEmail.Name;
      //  String caseCaNo    = caseobj.CaseNumber;
      //  String caseSubj   = caseobj.Subject;
      //  //String caseSupName =caseobj.SuppliedName;
      //  String caseDes = caseobj.Description;
      //  String userName  = toEmail.Name;
      //  String userPhone = toEmail.Email;
      //  String userEmail = toEmail.Phone;
      //  String Subject1=Subject.replace('{!Contact.FirstName}',str)
      //                         .replace('{!Case.CaseNumber}',caseCaNo);
      //  system.debug('Subject1>>>>>>>>>'+Subject1);
      //  String Body1= Body.replace('{!Contact.FirstName}',str)
      //                    .replace('{!Case.CaseNumber}',caseCaNo)
      //                    .replace('{!Case.Subject}',caseSubj)
      //                    //.replace('{!Case.SuppliedName}',caseSupName)
      //                    .replace('{!Case.Description}',caseDes)
      //                    .replace('{!User_Name}',userName)
      //                    .replace('{!User.Phone}',userPhone)
      //                    .replace('{!User.Email}',userEmail) 
      //                    .replace('{!Organization.Name}','Raagvitech');
      //  system.debug('Body1>>>>>>>>>>>>'+Body1);
       
    //    System.debug('Email'+toEmail.Email);
    //    String conName = toEmail.Name;
    //    String conEmail = toEmail.Email;
    //    String conPhone = toEmail.Phone;
    //    String conCreated = toEmail.CreatedById;
    //    //List<String> body = new List<String>();
        
         EmailTemplate lstEmailTemplates = [SELECT Id, Body, Subject 
                                            FROM EmailTemplate 
                                            WHERE Id =:templateId];
         System.debug('lstEmailTemplates'+lstEmailTemplates);
         // If we know how many addresses the email will be sent to from this transaction
       // We can set the reserve capacity
         //Messaging.reserveSingleEmailCapacity(1);
         //We instantiate our single email message object 
         Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
            
           // Strings to hold the email addresses to which you are sending the email.
            //String[] toAddresses = new String[] {toEmail.Email};
            String[] toAddresses = new String[] {toEmail.Email};
            //String[] FromAddresses = new String[] {storeFromAdd}
            //String[] FromAddresses = new String[] {storeFromAdd};
            // mail1.setTemplateId(lstEmailTemplates.Id);
            // mail1.setSaveAsActivity(true);
            // Contact con = new Contact
            // Contact conEmail = [SELECT Id, FirstName, LastName, Phone
            //                     FROM Contact
            //                     WHERE LastName=:storeEmail LIMIT 1];
             //System.debug('conEmail>>>>>>>>>>>>>>'+conEmail);
            mail1.setTargetObjectId(toEmail.Id);
            //mail1.setTargetObjectId(caseobj.Id);
            mail1.setToAddresses(toAddresses);
            mail1.setTemplateId(lstEmailTemplates.Id);
            //mail1.setFromAddresses(storeFromAdd);
            //mail1.setPlainTextBody(Body);
            mail1.setSubject(Subject1);
            
            //mail1.setWhatId(c.Id); // Enter your record Id whose merge field you want to add in template
            List<Messaging.SingleEmailMessage> allEmail = new List<Messaging.SingleEmailMessage>();
            allEmail.add(mail1);
            Messaging.sendEmail(allEmail);  
            System.debug('verified');
            // create savepoint before executing statement
            //Savepoint sp = Database.setSavepoint();

             // send the temporary email list
            // Messaging.sendEmail(allEmail);

            // rollback the transaction before commiting to database
            //Database.rollback(sp);

            // Send the emails in a transaction, then roll it back
            //Savepoint sp = Database.setSavepoint();
           // Messaging.sendEmail(allEmail);
            //Database.rollback(sp);
            

    }

    @AuraEnabled(cacheable=true)
    public static mergeDataforEmailTemplate sendEmail2( String storeLName1, Id templateId1){
     String emailSubject='';
     String emailBody='';
     System.debug('storeLName1>>>>>>>>'+storeLName1);
     System.debug('templateId1>>>>>>>'+templateId1);
     //System.debug('emailSubject>>>>>>>>>>>>.'+emailSubject);
     //System.debug('emailBody>>>>>>>>>>>>.'+emailBody);
     //Messaging.reserveSingleEmailCapacity(1);

     EmailTemplate emTemppp = [SELECT Subject,body
                               FROM EmailTemplate
                               WHERE Id =: templateId1];
      System.debug('emTemppp>>>>>>>>>>>>>>>>>>'+emTemppp);

      Contact email = [SELECT FirstName, LastName, Phone, Email
                       FROM Contact
                       WHERE LastName =: storeLName1];
       System.debug('contacttt');
       System.debug('email>>>>>>>>>>>>>>>'+email);
       Messaging.SingleEmailMessage mail2 = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[] {'wekone8076@mailvxin.net'};
       mail2.setTargetObjectId(email.Id);
       mail2.setToAddresses(toAddresses);
       mail2.setTemplateId(emTemppp.Id);
       //mail1.setFromAddresses(storeFromAdd);
       //mail1.setPlainTextBody(Body);
       //mail1.setSubject(Subject1);
       
       //mail1.setWhatId(c.Id); // Enter your record Id whose merge field you want to add in template
       System.debug('before savepoint');
      // Savepoint sp = Database.setSavepoint();
       List<Messaging.SingleEmailMessage> allEmail1 = new List<Messaging.SingleEmailMessage>();
       allEmail1.add(mail2);
       Messaging.sendEmail(allEmail1);  
       System.debug('verified');
       
       System.debug('after savepoint');

       if(String.isNotBlank(mail2.getSubject()))
       {
         emailSubject=mail2.getSubject(); 
         system.debug('if conditions');
         System.debug('emailSubject>>>>>>>>>>>>'+emailSubject);
       }
       if(String.isNotBlank(mail2.getHtmlBody()))
       {
         emailBody=mail2.getHtmlBody(); 
         System.debug('emailBody-getHTMLBody>>>>>>>>>>>>'+emailBody);
       }
       else
       {
         emailBody=mail2.getPlainTextBody(); 
         System.debug('emailBody -plainTextBody>>>>>>>>>>>>'+emailBody);
       }
      
       //Database.rollback(sp);
    
mergeDataforEmailTemplate emailWrap = new mergeDataforEmailTemplate();
emailWrap.emailSubject1 = emailSubject;
emailWrap.emailBody1 = emailBody;
System.debug('emailWrap>>>>>>>>>>>>>.'+emailWrap);
return emailWrap;
      }


public class mergeDataforEmailTemplate
{
   @AuraEnabled
   public String emailSubject1;
   @AuraEnabled
   public string emailBody1;
     
      
   }
}