global class LeadProcessor implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([SELECT LeadSource FROM Lead]);
    }
    public void execute(Database.BatchableContext BC, List<Lead> Scope)
    {
        for(Lead lead :Scope)
        {
            lead.LeadSource='Dreamforce';
        }
    }
    public void finish(Database.BatchableContext BC)
    {
        
    }
}