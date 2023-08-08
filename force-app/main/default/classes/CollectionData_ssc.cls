public class CollectionData_ssc {
    @AuraEnabled
    public static String storeContact(String Fnm, String Lnm, String Ph, String Em,String accId){
        String result;
        try
        {
        Contact con = new Contact();
        con.FirstName=Fnm;
        con.LastName=Lnm;
        con.Phone=Ph;
        con.Email=Em;
        con.accountId = accId;
        insert con;
            System.debug('con>>>>>>>>>>>>>>>'+con);
            result='Contact is inserted Sucessfully in the accountId of'+con.accountId;
        }
        catch(exception e)
        {
            result='Contact is not inserted bcoz of error'+e.getMessage();
        }
        return result;
        
    }

}