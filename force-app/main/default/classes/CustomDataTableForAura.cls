public class CustomDataTableForAura {
    @AuraEnabled
    public static List<Contact> gettingContacts(Id recId)
    {
        List<Contact> conList=[SELECT FirstName, LastName, Phone, Email, Languages__c, Title
                               FROM Contact
                               WHERE accountId =: recId];
        System.debug('conList>>>>>>>>'+conList);
        return conList;
    }
    

}