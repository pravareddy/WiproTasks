public class ContactTriggerHandler1 {
    public static void testBeforeContact(List<Contact> conList)
    {
        
    
        for(Contact con:conList)
        {
            con.LastName = con.Id+con.LastName;
            
        }
        
    }

}