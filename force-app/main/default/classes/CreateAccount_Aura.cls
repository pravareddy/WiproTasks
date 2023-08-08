public class CreateAccount_Aura {
    @AuraEnabled
    public static String createAccount(String fnm, String lnm, String Ph, String em)
    {
        String result;
        try
         {
           Contact con = new Contact();
           con.FirstName=fnm;
           con.LastName=lnm;
           con.Phone=ph;
           con.Email=em;
          
            insert con;
            result=''+con.accountId;
            }
        catch(exception e)
          {
            result=e.getMessage();
           }
        return result;
    }

}