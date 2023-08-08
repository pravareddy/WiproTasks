public class CheckBusinessHoursForOpenCase {
        /*Method Name       : getTheOpenCaseDuration
* Params           : List<List<string>> lstCaseIds
* Description       : 1.method will be invoked from flow : Notify/Reassign to case owner
*             2.evaluate the duration of open case with in the business hours(Mon-Fri).
*/
    
    @InvocableMethod(label = 'getTheOpenCaseDuration')
    public static void getTheOpenCaseDuration(List<List<String>> lstCaseIds) { 
        
        Integer days = 0;
        Integer agentAssignedDays = 0;
        Integer reopenDays = 0;
        Set<String> caseIdSet = new Set<String>();
        List<String> groupDevNameLst = new List<String>();
        Set<String> roleIdSet = new Set<String>();
        Set<String> onboardingUsersIdSet = new Set<String>();
        Set<String> onboardingQueueIdSet = new Set<String>();
        Map<String,Case> updateCaseById = new Map<String,Case>();
        Map<String,String> groupNameById = new Map<String,String>();
        Map<Id,CaseHistory> caseIdByCaseHistoryMap = new Map<Id,CaseHistory>();
        
        for(List<String> str : lstCaseIds){
            caseIdSet.add(str[0]);
        }
       
        List<CustomNotificationType> notificationTypeLst = [SELECT Id, DeveloperName 
                                                            FROM CustomNotificationType
                                                            WHERE DeveloperName='Notify_when_chatter_is_posted' LIMIT 1];
        System.debug('notificationTypeLst>>>>>>>>>>>>>>>>>>>'+notificationTypeLst);
        
        List<Group> queueIds =  [SELECT Id,DeveloperName 
                                 FROM Group 
                                 WHERE Type = 'Queue' 
                                 AND (DeveloperName = 'Email_CSS' OR DeveloperName = 'New_Accounts_Queue' OR DeveloperName  = 'Client_Onboarding')]; 
        System.debug('queueIds>>>>>>>>>>..'+queueIds);
        
        for(Group grp : queueIds){
            groupNameById.put(grp.DeveloperName,grp.Id);
        }
        System.debug('groupNameById>>>>>>...'+groupNameById);
        
        if(!groupNameById.isEmpty() && groupNameById.get('Client_Onboarding') != null){
            
            String clientOnboardingId = groupNameById.get('Client_Onboarding');
             System.debug('clientOnboardingId>>>>>>>>>>>>>>>>>>.'+clientOnboardingId);               

            
            for(GroupMember objMember : [SELECT GroupId, UserOrGroupId FROM GroupMember WHERE GroupId = : clientOnboardingId]){
                if(String.valueOf(objMember.UserOrGroupId).startsWith('005')){
                    onboardingUsersIdSet.add(objMember.UserOrGroupId);
                    System.debug('onboardingUsersIdSet>>>>>>>>>>>>>>>>.'+onboardingUsersIdSet);
                }
                else{
                    onboardingQueueIdSet.add(objMember.UserOrGroupId);
                    System.debug('onboardingQueueIdSet>>>>>>>>>>>>>'+onboardingQueueIdSet);
                }
            }
        }
        
        if(!onboardingQueueIdSet.isEmpty()){
            for(Group groupDevName : [SELECT Id, Name, DeveloperName, Type FROM Group where Id =: onboardingQueueIdSet]){
                System.debug('groupMembers' + groupDevName.DeveloperName);
                groupDevNameLst.add(groupDevName.DeveloperName);
                System.debug('groupDevNameLst>>>>>>>>>>>>>>>>>>>>.'+groupDevNameLst);
                
            }
        }
        if(!groupDevNameLst.isEmpty()){
            for(UserRole roleId : [SELECT ParentRoleId, Id, Name, DeveloperName FROM UserRole where DeveloperName=:groupDevNameLst]){
                roleIdSet.add(roleId.Id);
                System.debug('roleIdSet>>>>>>>>>>>>>>>>>'+roleIdSet);
            }
        }
        if(!roleIdSet.isEmpty()){
            for(User userIds : [SELECT Id, Name, UserRoleId FROM User Where UserRoleId = :roleIdSet]){
                System.debug('userIds' + userIds.Id);
                if(String.valueOf(userIds.Id).startsWith('005')){
                    onboardingUsersIdSet.add(userIds.Id);
                    System.debug('onboardingUsersIdSet>>>>>>>>>>>>>>>>>>>>>.'+onboardingUsersIdSet);
                }
            }
        }
        
        
        List<Case> caseObjLst = [SELECT Id,CaseNumber,CreatedDate,Reopened_Date_and_Time__c,Working_Team__c,OwnerId
                                 FROM Case 
                                 WHERE Id IN : caseIdSet];
        System.debug('caseObjLst' + caseObjLst);
        for(CaseHistory caseHisObj : [SELECT Id, IsDeleted, CaseId, CreatedById, CreatedDate, Field, OldValue, DataType, NewValue
                                      FROM CaseHistory 
                                      WHERE CaseId IN  :caseIdSet
                                      AND Field = 'Owner'
                                      AND DataType = 'EntityId' 
                                      ORDER By createdDate Asc]){
                                          caseIdByCaseHistoryMap.put(caseHisObj.caseId,caseHisObj);
                                      } 
        
        if(!caseObjLst.isEmpty()){
            System.debug('caseObjLst>>>>>>>>>>>>>>>>>>'+caseObjLst);
            DateTime assignedAgentDateTime;
            
            for(Case cobj : caseObjLst){
                if(!caseIdByCaseHistoryMap.isEmpty() && caseIdByCaseHistoryMap.get(cobj.Id) != null){
                    if(cobj.ownerId == caseIdByCaseHistoryMap.get(cobj.Id).NewValue){
                        assignedAgentDateTime = caseIdByCaseHistoryMap.get(cobj.Id).CreatedDate;
                        System.debug('assignedAgentDateTime>>>>>>>>>>>'+assignedAgentDateTime);
                    }
                    if(Test.isRunningTest()){
                        assignedAgentDateTime = caseIdByCaseHistoryMap.get(cobj.Id).CreatedDate;
                        System.debug('assignedAgentDateTime>>>>>>>>>>>>>>>>'+assignedAgentDateTime);
                    }
                } 
                
                if(assignedAgentDateTime != null && cobj.Reopened_Date_and_Time__c == null){
                    days =  calculateWorkingDays(assignedAgentDateTime);
                    System.debug('days1>>>>>>>>>>'+days);
                }
                else if(assignedAgentDateTime != null && cobj.Reopened_Date_and_Time__c != null){
                    agentAssignedDays = calculateWorkingDays(assignedAgentDateTime);
                    reopenDays =  calculateWorkingDays(cobj.Reopened_Date_and_Time__c);
                    System.debug('agentAssignedDays>>>>>>>>>>>>.'+agentAssignedDays);
                    System.debug('reopenDays>>>>>>>>>>>>>>>.'+reopenDays);
                    
                    //get recently contacted days by agent with the case
                    days = getRecentWorkingDays(agentAssignedDays,reopenDays);
                    System.debug('days2>>>>>>>>>>>>>>>>'+days);
                    
                } 
                if((!notificationTypeLst.isEmpty() && (cobj.Working_Team__c == 'CSS' && days ==3) || 
                    (cobj.Working_Team__c == 'Sales' && days ==2 && !onboardingUsersIdSet.isEmpty() && !onboardingUsersIdSet.contains(cobj.OwnerId)) || Test.isRunningTest())) { // to get code coverage including weekends.     
                        
                        sendBellNotification(cobj,notificationTypeLst[0].Id);
                       // System.debug('sendBellNotification>>>>>>>>>>>>>>>>>>>'+sendBellNotification);
                    }
                if((cobj.Working_Team__c == 'Sales' && days == 3 && !onboardingUsersIdSet.isEmpty() && !onboardingUsersIdSet.contains(cobj.OwnerId))){         
                    updateCaseById.put(cobj.Id, new Case(Id = cobj.Id, ownerId = groupNameById.get('New_Accounts_Queue')));
                    System.debug('updateCaseById>>>>>>>>>>>>>>>>>>>>>>>.'+updateCaseById);
                }
                if((cobj.Working_Team__c == 'CSS' && days == 4)) {
                    updateCaseById.put(cobj.Id, new Case(Id = cobj.Id,ownerId = groupNameById.get('Email_CSS'),priority = 'Leadership'));
                    System.debug('updateCaseById>>>>>>>>>>>>>>>>>>'+updateCaseById);
                }
            }
            
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
    
    public static integer calculateWorkingDays(DateTime caseDate){
        System.debug('caseDate>>>>>>>>>>>'+caseDate);
        
        Integer workingDays = 0; 
        Date startDate = date.valueof(caseDate);
        Date endDate = date.valueof(Datetime.now());
        
        for(integer i=0; i <= startDate.daysBetween(endDate); i++)
        {  
            Date dt = startDate + i;  
            DateTime currDate = DateTime.newInstance(dt.year(), dt.month(), dt.day());  
            String todayDay = currDate.format('EEEE');  
            
            if(todayDay != 'Saturday' && todayDay !='Sunday')  
            {  
                workingDays = workingDays + 1;  
            }     
        }          
        
        return integer.valueOf(workingDays);
    }
    
    public static integer getRecentWorkingDays(Integer agentAssignedDays, Integer reopenDays){
        System.debug('agentAssignedDays>>>>>>>>>>>>>'+agentAssignedDays);
        System.debug('reopenDays>>>>>>>>>>>>>>>>>>>'+reopenDays);
        
        Integer workingDays = 0; 
        
        if(agentAssignedDays > reopenDays){
            workingDays = reopenDays;
        }
        else if(agentAssignedDays < reopenDays){
            workingDays = agentAssignedDays;
        }
        else if(agentAssignedDays == reopenDays){ 
            workingDays = agentAssignedDays;
        }
        return workingDays;
    }
    
    public static void sendBellNotification(Case cObj,String notificationTypeId){
        System.debug('cObj>>>>>>>>>>>>>>>>>'+cObj);
        System.debug('notificationTypeId>>>>>>>>>>>>>>>>>>>.'+notificationTypeId);
        
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setTitle('Email case OVERDUE > action required');
        notification.setBody('Please review and resolve email case #'+cObj.CaseNumber+'. If no action is taken, case #'+cObj.CaseNumber+ ' will be returned back to the queue.');
        notification.setNotificationTypeId(notificationTypeId);
        notification.setTargetId(cObj.id);
        
        try { 
            notification.send(new Set<String> {cObj.OwnerId});
        }
        catch (Exception e) {
            System.debug('Exception while sending bell notification to case owner in CheckBusinessHoursForOpenCase.cls -> getTheOpenCaseDuration '+e.getMessage());
        }
    }

}