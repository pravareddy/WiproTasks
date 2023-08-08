public class myBatchClass implements Database.Batchable<sObject>{
  
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return null;
    }
    public void execute(Database.BatchableContext bc, List<sObject> records){
        // process each batch of records
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}