import { LightningElement,api,track} from 'lwc';
import displayContacts from '@salesforce/apex/AccountRelatedContacts.displayContacts'
export default class DisplayAccRelatedContacts extends LightningElement {
@api recordId;
@track storeConRec=[];
connectedCallback()
{
    console.log('recordId>>>>>>>>>>>>'+this.recordId);
    displayContacts({recId:this.recordId})
    .then(result=>{
        console.log('result>>>>>>>>>>>>'+JSON.stringify(result));
        this.storeConRec = result;
        console.log('this.storeConRec>>>>>>>>>>>>>.'+JSON.stringify(this.storeConRec));
    })
}
// @track storeContacts={};
// connectedCallback()
// {
//     console.log('recordId>>>>>>>>>>>'+this.recordId);

// displayContacts({recId:this.recordId})
// .then(result => {
//     console.log('Result ==> ', result);
//     this.storeContacts=result;
//     console.log('this.storeContacts>>>>>>>>>>>>>>>>>>'+this.storeContacts);


// });
//}




}