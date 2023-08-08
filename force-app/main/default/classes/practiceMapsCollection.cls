public class practiceMapsCollection {
    public static void practiceMapMethods()
    {
        Schema.Account a = new Schema.Account();
        a.Name='LackMe';
        a.Phone='9948058031';
        
        Map<Integer, Schema.Account> map1 = new Map<Integer, Schema.Account> {};
        map1.put(1, a);
       System.debug('map1>>>>>>>'+map1);
        Map<Integer, Schema.Account> map2 = map1.deepClone();
        map2.get(1).Name='Dazzler';
        System.debug('map1.get(1).Name>>>>>>>>>>>>'+map1.get(1).Name);
        System.debug('map2.get(1).Name>>>>>>>>>>>>'+map2.get(1).Name);
        
        
    }

}