@isTest
public with sharing class Test_review_Comp_RatingApex {
    @isTest static void saveFieldsInRating()
    {
        Rating__c rating = new Rating__c(Name__c='ananya',Enter_Review__c='fabolous',Rating__c=5);
        
        Test.startTest();
        insert rating;
        Test.stopTest();
        //retrieving the record
        Rating__c rating1=[SELECT Name__c, Enter_Review__c, Rating__c
                FROM Rating__c
                WHERE Id =:rating.Id];
        System.assertEquals('ananya', rating1.Name__c);
    }
}