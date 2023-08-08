global class batchUpdateAccountsandContacts implements Database.Batchable<sObject>{
    Set<id> successRecord = new Set<id>();
    Set<id> failedRecord = new Set<id>();
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String Query='SELECT FirstName,LastName FROM Contact';
        return Database.getQueryLocator(Query);
        
    }
    global void Execute(Database.BatchableContext BC,List<Contact> scope)
    {
        System.debug('Execute method>>>>>>>>>');
        System.debug('scope>>>>>>>>>'+scope);
        
        List<Contact> conList = new List<Contact>();
       
            for(Contact con:scope)
            {
              con.LastName='kasireddi';
              conList.add(con);
            }
        
        System.debug('conList>>>>>>'+conList);
        Database.SaveResult[] srList = Database.update(conList, false);
         System.debug('srList>>>>>>>>>'+srList);
        for(Database.SaveResult sr : srList)
        {
            if(sr.isSuccess())
            {
                successRecord.add(sr.getId());
            }
            else
            {
                for(Database.Error err:sr.getErrors())
                {
                   failedRecord.add(sr.getId());
                }
            }
        }
        System.debug('successRecord>>>>>>>>>'+successRecord);
        System.debug('failedRecord>>>>>>>'+failedRecord);
    }
    global void Finish(Database.BatchableContext BC)
    {
    }
}