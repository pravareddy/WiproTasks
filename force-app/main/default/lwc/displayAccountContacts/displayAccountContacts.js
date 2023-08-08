import { LightningElement, api, wire } from 'lwc';
import getAllAccountsWithContacts from '@salesforce/apex/AccountContactWrapper.getAllAccountsWithContacts';
export default class DisplayAccountContacts extends LightningElement {

    @api AccountsWithContacts;
    @api error;
    @wire(getAllAccountsWithContacts)
    wiredAccountsWithContacts({error,data})
    {s
        if(data)
        {
            this.AccountsWithContacts = data;
            //console.log('AccountsWithContacts>>>>>>' + this.AccountsWithContacts);
        }
        else if(error)
        {
            console.log(error);
            this.error = error;
        }
        console.log('AccountsWithContacts>>>>>>' + this.AccountsWithContacts);
    }
    

}