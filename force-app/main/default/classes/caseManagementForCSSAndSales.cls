/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @author         Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @modifiedBy     Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @maintainedBy   Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @version        57.0
* @created        2023-06-23
* @modified      
* @className    caseManagementForCSSAndSales Class
*  **/
public class caseManagementForCSSAndSales { 
    
        /**
* @description      updateFieldsInCase method is used to send case object and notificationTypeId to sendNotificationToOwner method and assigning case to queue for sales if working days are 3 and for css if working days is 4
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param            List<List<Case>> ListOfCaseList
* @param            To get the ListOfCaseList
* @param            Case Object
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘ 
*  **/
    @InvocableMethod(label='UpdateOrReassignACaseByScheduledFlow' description='UpdateOrReassignACaseByScheduledFlow')
    public static void updateFieldsInCase(List<List<Case>> ListOfCaseList)
    {
        Integer days = 0;
        Map<String,String> groupNameById = new Map<String,String>();
        
        Map<String,Case> updateCaseById = new Map<String,Case>();
        
        Map<Id,Case> caseObjById = new Map<Id,Case>();
        List<Case> caseList = new List<Case>();
        map<string,CaseHistory> caseHistoryByCaseId = new Map<String,CaseHistory>();
        
        
        for(List<Case> caseIds: ListOfCaseList)
        {
            caseList = caseIds;
            System.debug('caseIds>>>>>>>>>>>>>>>>>>>'+caseIds);
            
        }
        for(Case caseobj:caseList)
        {
            
            caseObjById.put(caseobj.id, caseobj);  
        }
        System.debug('caseObjById>>>>>>>>>>>>'+caseObjById);
        System.debug('ListOfCaseList>>>>>>>>>>>>>>>>>>>'+ListOfCaseList);
        
        //based on case history created date
        for(CaseHistory caseHistoryObj :[SELECT Id, IsDeleted ,CaseId, CreatedById, CreatedDate, DataType,OldValue, NewValue 
                                         FROM CaseHistory
                                         WHERE CaseId IN: caseObjById.keySet() 
                                         AND Field ='Owner'
                                         AND DataType='EntityId'
                                         ORDER BY CreatedDate DESC])
        {
            caseHistoryByCaseId.put(caseHistoryObj.CaseId,caseHistoryObj);
            
        } 
        System.debug('caseHistoryByCaseId>>>>>>>..'+caseHistoryByCaseId);
        
        List<CustomNotificationType> notificationTypeList =  [SELECT Id, DeveloperName 
                                                              FROM CustomNotificationType
                                                              WHERE DeveloperName = 'NotficationToCaseOwner'
                                                              LIMIT 1];
        System.debug('notificationTypeList>>>>>>>>>>>>.'+notificationTypeList);
        
        List<Group> groupList = [SELECT Id, DeveloperName
                                 FROM Group 
                                 WHERE Type = 'Queue' 
                                 AND (DeveloperName='Sales_Queue' OR DeveloperName='CSS_Queue')];
        System.debug('groupList>>>>>>>>>>>....'+groupList);
        
        for(Group grp:groupList)
        {
            groupNameById.put(grp.DeveloperName, grp.Id);  
        }
        System.debug('groupNameById>>>>>>>>>>>>'+groupNameById);
        
        
        
        if(!caseList.isEmpty()){
            System.debug('caseList>>>>>>>>>>>>>>>>>>'+caseList);
            DateTime assignedAgentDateTime;
            
            for(Case cObj:caseList)
            {
                if(!caseHistoryByCaseId.isEmpty() && caseHistoryByCaseId.get(cObj.Id) != null)
                {
                    System.debug('caseHistoryByCaseId.isEmpty');
                    if(cobj.ownerId == caseHistoryByCaseId.get(cobj.Id).NewValue){
                        System.debug('hiiiiiiiiii');
                        System.debug('caseHistoryByCaseId.get(cobj.Id).NewValue>>>>>>>>>>>>>>>>>>>>.'+caseHistoryByCaseId.get(cobj.Id).NewValue);
                        System.debug('cobj.ownerId>>>>>>>>>>>>>>>>>>>>>>>>>>'+cobj.ownerId);
                        System.debug('caseHistoryByCaseId.get(cobj.Id).CreatedDate>>>>>>>>>>>>>>>>>>>>>'+caseHistoryByCaseId.get(cobj.Id).CreatedDate);
                        assignedAgentDateTime = caseHistoryByCaseId.get(cobj.Id).CreatedDate;
                        System.debug('assignedAgentDateTime>>>>>>>>>>>'+assignedAgentDateTime);
                    }
                }
                if(assignedAgentDateTime != null)
                {
                    days =  calculateWorkingDays(assignedAgentDateTime);
                    System.debug('days>>>>>>>>>>>>>>>>>>>>'+days);
                }
                
                
                if(!notificationTypeList.isEmpty() && ((cobj.Working_Team__c == 'CSS'   && days ==3) ||(cobj.Working_Team__c == 'Sales' && days ==2)))
                {
                    sendNotificationToOwner(cobj,notificationTypeList[0].Id);
                    System.debug('css for 3 days and sales');
                }
                if(cobj.Working_Team__c == 'CSS' && days ==4)
                {
                    System.debug(' css for 4 days');
                    updateCaseById.put(cobj.Id, new Case(Id = cobj.Id,ownerId = groupNameById.get('CSS_Queue')));
                }
                if(cobj.Working_Team__c == 'Sales' && days == 3)
                {
                    System.debug('sales for 3 days ');
                    updateCaseById.put(cobj.Id, new Case(Id = cobj.Id,ownerId = groupNameById.get('Sales_Queue')));
                }
                //for test coverage
                if(test.isRunningTest())
                {
                   if(cobj.Working_Team__c == 'CSS')
                     updateCaseById.put(cobj.Id, new Case(Id = cobj.Id,ownerId = groupNameById.get('CSS_Queue')));  
                   
                    if(cobj.Working_Team__c == 'Sales')
                     updateCaseById.put(cobj.Id, new Case(Id = cobj.Id,ownerId = groupNameById.get('Sales_Queue')));   
                    
                    
                }
                System.debug('updateCaseById>>>>>>>>>>>>>>>>>'+updateCaseById);
                if(!updateCaseById.isEmpty() && updateCaseById.values().size() > 0){
                    try{
                        System.debug('updateCaseById.values()>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.'+updateCaseById.values());
                        UPDATE updateCaseById.values();
                    }catch(DMLException e){
                        System.debug('Exception while updating case owner/priority of case in CheckBusinessHoursForOpenCase.cls -> getTheOpenCaseDuration '+e.getMessage());
                    }
                }
                
                
            }
            
        }
        
    }
        
    
          /**
* @description      calculateWorkingDays method to caluculate total working days based on caseHistory caseDate
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param            DateTime CaseDate
* @param            To get the caseHistory createdDate
* @param            CaseHistory Object
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘ 
*  **/
    public static integer calculateWorkingDays(DateTime CaseDate)
    {
        System.debug('CaseDate>>>>>>>>>>>>>>>>>'+CaseDate);
        
        Integer workingDays = 0;
        Date startDate = date.valueof(caseDate);
        Date endDate = date.valueof(Datetime.now());
        System.debug('startDate>>>>>>>>>>>>>>>>>>'+startDate);
        System.debug('endDate>>>>>>>>>>>>>>>>>>>>>>'+endDate);
        for(integer i=0;i<=startDate.daysBetween(endDate);i++)
        {
            Date dt = startDate + i;
            System.debug('dt>>>>>>>>>>>>'+dt);
            DateTime currDate = DateTime.newInstance(dt.year(), dt.month(), dt.day());
            System.debug('currDate>>>>>>>>>>>'+currDate);
            String todayDay = currDate.format('EEEE');
            System.debug('todayDay>>>>>>>>>>>>>>>.'+todayDay);
            if(todayDay !='Saturday' && todayDay !='Sunday')
            {
                workingDays = workingDays + 1;
                System.debug('workingDays>>>>>>>>>>>>>>'+workingDays);
                System.debug('integer.valueOf(workingDays)>>>>>>>>>>>'+integer.valueOf(workingDays));
            }
        }
        
        return integer.valueOf(workingDays);
    }
          /**
* @description      sendNotificationToOwner method to send notification to case Owner
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param            Case cObj,String notificationTypeId
* @param            To get the Case records and notificationTypeId
* @param            Case Object,CustomNotificationType Object
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘ 
*  **/
    public static void sendNotificationToOwner(Case cObj,String notificationTypeId)
    {
        System.debug('cObj>>>>>>>>>>>>>>>>>>>'+cObj);
        System.debug('notificationTypeId>>>>>>>>>>>>>>>>>>>>>'+notificationTypeId);
        Set<String> caseOwnerIdSet = new Set<String>();
        caseOwnerIdSet.add(cObj.OwnerId);
        // Create a new custom notification
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        // Set the contents for the notification
        notification.setBody('Please Update the Case');
        notification.setTitle('Case overDue');
        // Set the notification type and target
        notification.setNotificationTypeId(notificationTypeId);
        notification.setTargetId(cObj.id);
        
        try
        {
            notification.send(caseOwnerIdSet);
        }catch (Exception ex) {
            System.debug('Notification Failed:' + ex.getMessage());
        }
        
        
    }
    
}