public with sharing class ChildForDisplayAccRelatecConsForAura {
    @AuraEnabled
    public static void saveContact(){
       List<Contact> conList = new List<Contact>();
       System.debug('conList>>>>>>>>>'+conList);
       insert conList;
    }
}