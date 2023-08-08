public with sharing class WrapperToCreateFields {
    @AuraEnabled(Cacheable=true)
   public static List<Order> disaplyFields()
   {
    String JsonString ='{"data":{"orders":[{"Id":"Ord12355767", "Name" : "SampleOrder1","TypeOfOrder" : "limit","status" :"Active"},{"Id":"Ord4678789","Name" : "SampleOrder2","TypeOfOrder" : "Unlimit","status" :"Not Active"}]}}';
    System.debug('JsonString>>>>>>>>>'+JsonString);
    Map<String, Object> rawObj = (Map<String, Object>) JSON.deserializeUntyped(JsonString);
    //Map<String,Object> rawObj = (Map<String, Object>) JSON.deserializeUntyped(JsonString);
    System.debug('rawObj>>>>>>>>>>'+rawObj);
     Map<String, Object> dataObj = new Map<String,Object>();
    dataObj = (Map<String,Object>) rawObj.get('data');
    System.debug('dataObj>>>>>>>>>>'+dataObj);
       List<Object> orderList = new List<Object>();
       List<Order> ordList = new List<Order>();
    if(dataObj.get('orders')!=null)
    {
        orderList = (List<Object>)dataObj.get('orders');
        System.debug('orderList :'+orderList);
        
        for(Object order:orderList )
        {
          Map<String, Object> dataObj1 = (Map<String,Object>)order;
           String id1 = (String) dataObj1.get('Id');
             String name1 = (String) dataObj1.get('Name');
            //System.debug(':'+name1);
            String TypeOfOrder1 =(String) dataObj1.get('TypeOfOrder');
            //System.debug(':'+TypeOfOrder1);
        	String status1 =(String) dataObj1.get('status');
            //System.debug(':'+status1);
            
            //assign fields values from JSON to order object
             Order orderObj = new Order();
             orderObj.Id=id1;
            orderObj.Name=name1;
            orderObj.status=status1;
            orderObj.TypeOfOrder=TypeOfOrder1;
            ordList.add(orderObj);
            System.debug('ordList>>>>>>>>'+ordList);
            
            
        }
    }
      
   // Order orderObj = new Order();
    
       
       
       // orderObj.Name = orderList.get(0).('Name');
       // System.debug('orderObj.Name>>>>>>>>>>'+orderObj.Name);
        //orderObj.TypeOfOrder = (String) dataObj.get('TypeOfOrder');
        //System.debug('orderObj.TypeOfOrder>>>>>>>>>>'+orderObj.TypeOfOrder);
       // orderObj.status = (String) dataObj.get('status');
        //System.debug('orderObj.status>>>>>>>>>>'+orderObj.status);
   
    //System.debug('orderObj>>>>>>>>>>>>'+orderObj);
    System.debug('ordList>>>>>>>>+++++++++++++'+ordList);
    return ordList;
   
   }
   //This method is used to store the data in salesforce which is coming from LWC
   @AuraEnabled
   public static void InsertOrders(List<Order__c> orderList)
   {
    System.debug('orderList>>>>>>>>>>>>>>>>>'+orderList);
    //insert orderList;
      // Order__c orderr = new Order__c();
      
       insert orderList;
       
   }
    public class Order
    {
      // public String Id;
      @AuraEnabled public String Id;
      @AuraEnabled public String Name;
      @AuraEnabled public String TypeOfOrder;
      @AuraEnabled public String status;
    }

}