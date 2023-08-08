public class AddRelatedRecordsHandler {
    public static void createOpp()
    {
        List<Opportunity> oppList = new List<Opportunity>();
        Map<Id,Schema.Account> accWithOpp =new Map<Id,Schema.Account>([SELECT Id,Name,(SELECT Id FROM Opportunities)
                                     FROM Account
                                     WHERE Id IN : Trigger.New]);
    }

}