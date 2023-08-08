public with sharing class review_Comp_RatingApex {
    @AuraEnabled
    public static void saveFieldsInRating(Rating__c ratingValues){
        
        List<Rating__c> ratingList = new List<Rating__c>();
        ratingList.add(ratingValues);
        system.debug('ratingValues>>>>>'+ratingValues);
        system.debug('ratingList>>>>>'+ratingList);
        insert ratingList;

        System.debug(ratingList[0].Id);
        
        
    }
}