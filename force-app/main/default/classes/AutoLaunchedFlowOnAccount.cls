public class AutoLaunchedFlowOnAccount {
    @InvocableMethod
    public static List<Schema.Account> returnAccounts(List<Id> ids)
    {
        List<Schema.Account> accList =[SELECT Id,Name,Phone
                               FROM Account
                               WHERE Id IN: ids];
        return accList;
    }

}