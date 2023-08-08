public class AccountProcessor {
    @future
    public static void countContacts(String accountIds)
        
    {
        List<Schema.Account>  accList = [SELECT Id, Name, Number_Of_Contacts__c	, (SELECT Id,LastName FROM Contacts)
                                         FROM Account
                                         WHERE Id =:accountIds];
        System.debug('accList----------'+accList);
        for(Schema.Account acc : accList)
        {
            List<Contact> conList = acc.Contacts;
            System.debug('conList-----------'+conList);
            acc.Number_Of_Contacts__c = conList.size();
            System.debug('conList.size()---------'+conList.size());
        }
        update accList;
    }

}