import { LightningElement,api,wire,track } from 'lwc';
import getAllContacts from '@salesforce/apex/ContactsInTableFormatApex.getAllContacts';
import {NavigationMixin} from 'lightning/navigation';
export default class ContactsInTableFormLWC extends NavigationMixin(LightningElement){
@track accountContacts=[];
@api recordId;
@wire(getAllContacts, {recId : '$recordId'})
wiredContacts({error,data})
{
    if(data)
     {  
         this.accountContacts = data;
         console.log('hlooo');
         console.log('this.accountContacts>>>>>>>>>>>>'+JSON.stringify(this.accountContacts));
        console.log('data>>'+JSON.stringify(data));
     }
   else if(error)
   {
    console.error(error); 
    }
}
// connectedCallback(){
//     getAllContacts({recId:this.recordId})
//     .then(result => {
//         console.log('the value 123')
//         this.accountContacts = result;
//         console.log('this.accountContacts>>>>>>>'+this.accountContacts);
//     })
// }
handleHyperLink(event)
{
    var conDetailsId = event.target.dataset.id;
    console.log('conDetailsId>>>'+conDetailsId);
    this[NavigationMixin.Navigate]({ 
        type:'standard__recordPage',
        attributes: {
            objectApiName : 'Contact',
            recordId : conDetailsId,
            actionName:'view',
        },
    });
}

}