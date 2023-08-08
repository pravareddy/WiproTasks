@isTest
public class NotificationsInAccountTabTest_T {
   /* @TestSetup static void setUpMethod(){
        NotificationsInAccountTab_T.notificationWrapper notifnWrapObj = new NotificationsInAccountTab_T.notificationWrapper();
        notifnWrapObj.type1='Email';
        notifnWrapObj.subject1='A new contact has been changed';
        notifnWrapObj.Message1='Hi your contact number got changed .will you please check and inform us';
        notifnWrapObj.ToAddress1='pravalikareddy3663@gmail.com';
        notifnWrapObj.CreatedTime1=System.now();
        String myJSON = JSON.serialize(notifnWrapObj);
        RestRequest request = new RestRequest();
        request.requestUri ='https://mindful-impala-lz6cbg-dev-ed.my.salesforce.com/services/apexrest/NotificationsInAccountTab_T';
         request.httpMethod = 'POST';
        request.requestBody = Blob.valueof(myJSON);
        RestContext.request = request;
        
    }*/
    @isTest  static void  method(){
        Test.setMock(HttpCalloutMock.class, new NotificationsInAccountTabMock_T());
        
        
}

}