public class AddPrimaryContact implements Queueable{
    Private Contact contacts;
    Private String state;
    public AddPrimaryContact(Contact contact, String State)
    {
        this.contacts=contact;
        this.state=State;
    }
    public void execute(QueueableContext context)
    {
        List<Schema.Account> accList = [SELECT Id,Name,(SELECT FirstName,LastName FROM Contacts) FROM Account WHERE BillingState =:State LIMIT 200];
        List<Contact> conList = new List<Contact>();
        for(Schema.Account acc:accList)
        {
            Contact con=contacts.clone();
            conList.add(con);
        }
        
        insert conList;
    }
    
}