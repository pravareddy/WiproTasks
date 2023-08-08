import { LightningElement,track } from 'lwc';
import gettingEmail from '@salesforce/apex/EmailSending_Apex.gettingEmail';
export default class EmailSending_LWC extends LightningElement {

 @track storeEmail='';
 @track storeConRecords=[];
 handleEmail(event)
    {
        
            this.storeEmail=event.target.value;
            console.log('this.storeEmail>>>>>>>>>'+this.storeEmail);
            gettingEmail({toAddress:this.storeEmail})
            .then(result => {
                console.log('Result ==> ', result);
                this.storeConRecords=result;
                console.log('this.storeConRecords>>>>>>>>>>>>'+JSON.stringify(this.storeConRecords));
            });
      
    }
    handleSendingEmail(event)
    {
       console.log('sending values');
    }
}