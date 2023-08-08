public class AccountHandler {
   public static void insertAccount(Integer numberofAccounts){
 

        Integer n = 1;
 

        List<Schema.Account> addAccounts=new List<Schema.Account>();
 

        while(n <= numberofAccounts){
 

            
 

          
 

            Schema.Account tempaccount=new Schema.Account();
 

            tempaccount.Name='Acme Inc '+ n;
 

            tempaccount.AccountNumber='A000'+ n;
 

            addAccounts.add(tempaccount);
 

            
 

            n=n+1;
 

        }
 

        insert addAccounts;
 

        
 

    }
 

}