public class Rating {
    @AuraEnabled(cacheable=true)
    public static void saveFieldsInRating(Rating__c ratingValues){
        List<Rating__c> ratingList = new List<Rating__c>();
        ratingList.add(ratingValues);
        system.debug('ratingValues>>>>>'+ratingValues);
        system.debug('ratingList>>>>>'+ratingList);
        upsert ratingList;
         System.debug(ratingList[0].Id);
    }

}