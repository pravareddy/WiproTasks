public with sharing class NotificationsInAccountTabStructure_T {
    public class data{
        public wrapNotificationDetails notificationDetails{get; set;}
    }
    public class wrapNotificationDetails
    {
        public List<wrapNotifications> notifications{get; set;}
    }
    public class wrapNotifications 
    {
        public String type{get; set;}
        public String subject{get; set;}
        public String Message{get; set;}
        public String ToAddress{get; set;}
        public DateTime CreatedTime{get; set;}
        
    }
    
}