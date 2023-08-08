import { LightningElement, track } from 'lwc';
import getContacts from '@salesforce/apex/RetrieveContactsForPromise.getContacts';
export default class DisplayContactsByUsingPromise extends LightningElement {
    @track storeContacts;
    contactPromise = getContacts();
    //console.log('contactPromise>>>>>>>.'+contactPromise);
    connectedCallback()
    {
        getContacts().then(result=>{
            this.storeContacts=result;
            console.log('this.storeContacts>>>>>>>>>>>>>>>>>>>>>>>>'+this.storeContacts);
        })
    }

}