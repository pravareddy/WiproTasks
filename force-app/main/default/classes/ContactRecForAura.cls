public with sharing class ContactRecForAura {
    @AuraEnabled
    public static List<Contact> gettingContact(Id recordId){
        List<Contact> conList = [SELECT FirstName, LastName, Phone, Email, Department
                                 FROM Contact
                                 WHERE accountId =:recordId];
            
        System.debug('dataTable with edit and delete buttons');
        System.debug('recId>>>>>>'+recordId);
        System.debug('conList>>>>>>>>>>'+conList);
        return conList;
       
    }
    @AuraEnabled
    public static void updatedContacts(List<Contact> contactRecords){

        //if(contactRecords!=null && contactRecords.size()>0)
        //{
            upsert contactRecords;
        //}
        System.debug('contactRecords>>>>>>>>>'+contactRecords);
    }
    @AuraEnabled
    public static Contact deletedRecords(String deletedRecId){
        System.debug('deletedRecId>>>>>>>>>>'+deletedRecId);
        Contact delcon = [SELECT Id, FirstName, LastName, Phone, Email, Department
                                 FROM Contact
                                 WHERE Id =:deletedRecId];
       delete delcon;
       System.debug('delcon>>>>>>>>>'+delcon);
       return delcon;
       
    }
}