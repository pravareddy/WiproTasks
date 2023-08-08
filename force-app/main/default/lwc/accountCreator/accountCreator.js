import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
export default class AccountCreator extends LightningElement {
    objectApiName = ACCOUNT_OBJECT;
    fields=[NAME_FIELD, INDUSTRY_FIELD, REVENUE_FIELD];
    
    handleSuccess(event)
    {
        //console.log('fields-------------'+fields);
    
        const toastEvent = ShowToastEvent({
            title:"Account Created",
            message:"Record Id" + event.detail.id,
            variant:"Success"

        });
        this.dispatchEvent(toastEvent);
    }


}