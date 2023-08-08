@isTest
public class DailyLeadProcessorTest {
//Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
   public static String CRON_EXP = '0 0 02 20 12 ? 2022';


    @isTest static void test_method_one() {

        List<Lead> lList = new List<Lead>();

     for(Integer i =0;i <200 ;i++){

         Lead lObj = new Lead(LastName = 'Test'+i, LeadSource =null,Company = 'Test Company'+i, Status ='Open - Not Contacted');


         lList.add(lObj);
     }
        


     if(lList.size() >0){

         Database.insert(lList,false);
     }


      Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('Update LeadSource to DreamForce', CRON_EXP, new DailyLeadProcessor());
       
        // Stopping the test will run the job synchronously
        Test.stopTest();
    
    

    System.assertEquals(200 , [Select count() From Lead where LeadSource ='Dreamforce' ]);
    
    }
    
}