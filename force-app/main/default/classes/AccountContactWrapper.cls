public with sharing class AccountContactWrapper {
    @AuraEnabled(cacheable=true)
    public static List<AccountContactListWrapper> getAllAccountsWithContacts(){
        List<AccountContactListWrapper> accConWrapperList = new List<AccountContactListWrapper>();
        List<Account> accList = [SELECT Id,Name,(SELECT Id,Name,Phone FROM Contacts) FROM Account];
        if(!accList.isEmpty())
        {
           for(Account acc : accList)
           {
            AccountContactListWrapper accConWrapper = new AccountContactListWrapper();
            accConWrapper.accRecord = acc;
            accConWrapper.contactList = acc.contacts;
            accConWrapper.contactCount = acc.contacts.size();
             
            accConWrapperList.add(accConWrapper);
           }
        }
       return accConWrapperList;
    }
    public class AccountContactListWrapper{
        public Account accRecord{get;set;}
        public List<contact> contactList{get;set;}
        public integer contactCount{get;set;}


    }
}