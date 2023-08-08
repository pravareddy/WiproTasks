public class contactsInTableFormatInApex {
    public static List<Contact> getAllContacts(Id recId){
       // List<Contact> conList = new List<Contact>();
        List<Contact> conList=[SELECT FirstName,LastName,Phone,Email,Department
                       FROM Contact
                       WHERE accountId =:recId];
        System.debug('conList>>>>'+conList);
        
         return conList;

    }

}