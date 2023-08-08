import { LightningElement,track } from 'lwc';
import saveFieldsInRating from '@salesforce/apex/review_Comp_RatingApex.saveFieldsInRating';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class review_Comp_RatingLwc extends LightningElement {
    //storeRating;
    //storeName;
    //storeReview;
    @track saveValues={};
    @track istrue = true;
    
    rating(event)
    { 

        if(event.target.label === "Name")
        {
            console.log('hiiiiiiiiiiiiii');
        this.saveValues.Name__c = event.target.value;
        console.log('this.saveValues.Name__c>>>>>>>>'+this.saveValues.Name__c);
        }  
        else if(event.target.label === "Enter Review")
        {
        this.saveValues.Enter_Review__c = event.target.value;
        console.log('this.saveValues.Enter_Review__c>>>>>>>>'+this.saveValues.Enter_Review__c);
        }  
         else if(event.target.name === "Rating")
        {
        this.saveValues.Rating__c = event.target.value;
        console.log('this.saveValues.Rating__c>>>>>>>>'+this.saveValues.Rating__c);
        console.log('saveValues>>>>>>>>>'+saveValues[0]);
        console.log('this.saveValues>>>>>>>>>'+this.saveValues);
        }
    }
    submitValues(event)
    {
        this.istrue = false;
        console.log('submitting');
        //saveValues=[];
            this.saveValues.SobjectType='Rating__c';
        //saveValues.Name__c = this.storeName;
        //saveValues.Enter_Review__c= this.storeReview;
        //saveValues.Rating__c = this.storeRating;
        console.log('this.saveValues>>>>'+JSON.stringify(this.saveValues));
        //console.log('saveValues>>>>'+saveValues);
        saveFieldsInRating({ratingValues : this.saveValues}).then(result => {
            this.istrue = true;
            console.log('created....');
            this.dispatchEvent(
                new ShowToastEvent({ 
                    title : 'Success',
                    message : 'submitted Rating Sucessfully',
                    variant : 'Success'


                })
            );
            //this.saveValues=[];
        })
    
        .catch(error => {
            this.istrue = true;
            console.log('Error: ', error);
        });
        [...this.template
            .querySelectorAll('lightning-input, input, label,name, lightning-tile')]
            .forEach((input) => { input.value = ''; });
            this.saveValues.Rating__c=[];

        console.log('ratingValues>>>>>>>>>>'+ratingValues);
       
    }
}