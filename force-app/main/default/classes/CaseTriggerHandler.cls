public class CaseTriggerHandler {
      public static void LimitNoOfCases(List<Case> caseList) {
        Integer monthNumber = Date.Today().Month();
          System.debug('monthNumber-----'+monthNumber);
        Integer yearNumber = Date.Today().Year();
          System.debug('yearNumber-----'+yearNumber);
        Integer maxCases = 10;
        List<Case> thisMonthCaseList = [SELECT id,CreatedById,CreatedDate 
                                        FROM case 
                                        WHERE CALENDAR_YEAR(CreatedDate) =:YearNumber 
                                        and CALENDAR_MONTH(CreatedDate)=:monthnumber 
                                        and CreatedById=:UserInfo.GetUserId()];
          
        System.debug('thisMonthCaseList-----'+thisMonthCaseList);
        if (thisMonthCaseList.Size()>=maxCases)         
            caseList[0].addError('Dear user you have exceeded the maximum number of cases allowed this month.');
    }

}