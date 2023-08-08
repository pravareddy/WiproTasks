@RestResource(urlMapping='/NotificationRecords/*')
global with sharing class NotificationsInAccountTab_T {
    @HttpPost
    global static void parseJson(){
        try{
            List<NotificationsInAccountTabStructure_T.data> notiInAccTabList = new List<NotificationsInAccountTabStructure_T.data>();

           // List<Notification> notificationList =new List<Notification>();
            RestRequest restReqst = RestContext.request;
            System.debug('restReqst.requestBody>>>>>>>>>>>>>>>>>>>>>>>>'+restReqst.requestBody);
            //System.debug('restReqst.requestBody.toString()>>>>>>>>>>'+restReqst.requestBody.toString());
            NotificationsInAccountTabStructure_T.data notiInAccTabObj = (NotificationsInAccountTabStructure_T.data) JSON.deserializeStrict(restReqst.requestBody.toString(), NotificationsInAccountTabStructure_T.data.class);
            notiInAccTabList.add(notiInAccTabObj);
            System.debug('httpPost');
            System.debug('notiInAccTabObj>>>>>>>>>>>>>'+notiInAccTabObj);
            System.debug('notiInAccTabList>>>>>>>>>.'+notiInAccTabList);
            if(!notiInAccTabList.isEmpty())
            {
                sendNotificationRecords(notiInAccTabList);
            }
                  
        }
        catch(Exception e){
            system.debug('ex: '+e.getMessage());
        }
        
    } 
    @AuraEnabled(Cacheable=true)
    public static List<notificationWrapper> sendNotificationRecords(List<NotificationsInAccountTabStructure_T.data> notiInAccTabList)
    {
        List<notificationWrapper> wrapNotificationList = new List<notificationWrapper>();
        System.debug('notiInAccTabList>>>>>>>>>>>>>>'+notiInAccTabList);
        for(NotificationsInAccountTabStructure_T.data notiInAccTabObj : notiInAccTabList){
             for(NotificationsInAccountTabStructure_T.wrapNotifications notfiObj : notiInAccTabObj.notificationDetails.notifications)
             {
                 System.debug('notiInAccTabObj>>>>>>>>>>>>'+notiInAccTabObj);
                 System.debug('notfiObj>>>>>>>>>.'+notfiObj);
                notificationWrapper wrapNotificationObj = new notificationWrapper();
                 wrapNotificationObj.type1=notfiObj.type;
                 wrapNotificationObj.subject1=notfiObj.subject;
                 wrapNotificationObj.Message1=notfiObj.Message;
                 wrapNotificationObj.ToAddress1=notfiObj.ToAddress;
                 wrapNotificationObj.CreatedTime1=notfiObj.CreatedTime;
                 wrapNotificationList.add(wrapNotificationObj);
                 System.debug('wrapNotificationObj>>>>>>>>>>>>>>>>'+wrapNotificationObj);
             }
        }
        System.debug('wrapNotificationList>>>>>>>>>>>>'+wrapNotificationList);
        return  wrapNotificationList;
    }
    public class notificationWrapper{
        @AuraEnabled
        public String type1{get; set;}
        @AuraEnabled
        public String subject1{get; set;}
        @AuraEnabled
        public String Message1{get; set;}
        @AuraEnabled
        public String ToAddress1{get; set;}
        @AuraEnabled
        public DateTime CreatedTime1{get; set;}
        
    }
}