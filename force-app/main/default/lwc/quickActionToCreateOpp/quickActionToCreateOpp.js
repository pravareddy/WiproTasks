import { LightningElement,wire,track, api } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import STAGE from '@salesforce/schema/Opportunity.StageName';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import Opportunity_OBJECT from '@salesforce/schema/Opportunity';
import getAccRec from '@salesforce/apex/OppRecForQuickActnInAccDetail_Apex.getAccRec';
import saveOppRecords from '@salesforce/apex/OppRecForQuickActnInAccDetail_Apex.saveOppRecords';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class QuickActionToCreateOpp extends LightningElement {
    @wire(getObjectInfo, { objectApiName: Opportunity_OBJECT })

 opportunityMetadata;


 // now retriving the StageName picklist values of Opportunity

 @wire(getPicklistValues,

     {

         recordTypeId: '$opportunityMetadata.data.defaultRecordTypeId', 

         fieldApiName: STAGE

     }
     )
     stageValues;

     @track UserEnteredValues=[];
      
    @track stageName;
    @track CloseDate;
     handleChange(event)
     {
        if(event.target.label === "Stage Name")
        {
               this.UserEnteredValues.StageName = event.target.value;
               console.log('this.UserEnteredValues.StageName>>>>>>>>>>>>>'+this.UserEnteredValues.StageName);
               this.stageName=this.UserEnteredValues.StageName
               console.log('this.stageName>>>>>>>.'+this.stageName);
              
        }
        else if(event.target.label === "Close Date")
        {
               this.UserEnteredValues.CloseDate = event.target.value;
               console.log('this.UserEnteredValues.CloseDate>>>>>>>>>>>>>'+this.UserEnteredValues.CloseDate);
               this.CloseDate=this.UserEnteredValues.CloseDate;
               console.log('this.CloseDate>>>>>>>>>.'+this.CloseDate);
              
        }
     }




     @api recordId;
     @track accRecords=[];
    
     @track accName;
      @track accOwner;
     @wire(getAccRec, {recId : '$recordId'})
wiredopp({error,data})
{
    if(data)
     {  
        this.accRecords = data;
        this.accName=this.accRecords[0].Name;
        this.accOwner=this.accRecords[0].Owner.Name;
         console.log('hlooo');
         console.log('this.accName>>>>>>>>>>>'+this.accName);
         console.log('this.accOwner>>>>>>>>>>>'+this.accOwner);
         console.log('this.accRecords>>>>>>>>>>>>'+JSON.stringify(this.accRecords));
         console.log('data>>'+JSON.stringify(data));
        }
        else if(error)
        {
         console.error(error); 
         }
     }


     handleCancel()
     {
        console.log('cancelling records in oppoortunity');
        [...this.template
            .querySelectorAll('lightning-input, lightning-combobox')]
            .forEach((input) => { input.value = ''; });
     }

     handleSave()
     {
        console.log('saving records in oppoortunity');
        saveOppRecords({Name1:this.accName,
                        CloseDate1:this.CloseDate,
                        StageName1:this.stageName,
                        recId:this.recordId
        })
        .then(result => {
             console.log('result is>>>>>>>>>.'+result);
                this.dispatchEvent(
                    new ShowToastEvent({ 
                        title : 'Success',
                        message : 'Opportunity Created Sucessfully',
                        variant : 'Success'
    
    
                    })
                );
            })
        
        .catch(error => {
            console.log('error in saving',error);
        });
        
     
     [...this.template
        .querySelectorAll('lightning-input, lightning-combobox')]
        .forEach((input) => { input.value = ''; });

     }

}