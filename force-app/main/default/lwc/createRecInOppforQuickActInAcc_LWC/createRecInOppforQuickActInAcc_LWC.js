import { LightningElement, wire, api, track} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import STAGE from '@salesforce/schema/Opportunity.StageName';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import Opportunity_OBJECT from '@salesforce/schema/Opportunity';
import getAccRec from '@salesforce/apex/OppRecForQuickActnInAccDetail_Apex.getAccRec';
import saveOppRecords from '@salesforce/apex/OppRecForQuickActnInAccDetail_Apex.saveOppRecords';


export default class CreateRecInOppforQuickActInAcc_LWC extends LightningElement {
 // getting the default record type id, if you dont' then it will get master

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
     @track oppRecords=[];
     @track oppRecs=[];
     handleChange(event)
    {
        
         if(event.target.label === "Close Date")
        {
               this.oppRecs.CloseDate = event.target.value;
               console.log('this.oppRecs.CloseDate>>>>>>>>>>>>>'+this.oppRecs.CloseDate);
        }
        else if(event.target.label === "Stage Name")
        {
               this.oppRecs.StageName = event.target.value;
               console.log('this.oppRecs.StageName>>>>>>>>>>>>>'+this.oppRecs.StageName);
        }
    }

     @api recordId;
     @track accRecords=[];
    
     //@track accName;
      //@track accOwner;
     @wire(getAccRec, {recId : '$recordId'})
wiredopp({error,data})
{
    if(data)
     {  
        // var obj = {};
        // obj.OwnerId = data[0].Owner.Name;
        // obj.Name = data[0].Account.Name;
        // obj.CloseDate = null
        // obj.StageName = null;
        //console.log('')
         this.accRecords = data;
         console.log('hlooo');
         console.log('this.accRecords>>>>>>>>>>>>'+JSON.stringify(this.accRecords));
         console.log('data>>'+JSON.stringify(data));
        // this.accName=this.accRecords[0].Name;
        //  console.log('this.accName>>>>>>>>>>>>>>'+this.accName);
        //   this.accOwner=this.accRecords[1].OwnerId;
        //   console.log('this.accOwner>>>>>>>>>>>>>>'+this.accOwner);
          console.log('everything done123');
          //this.oppRecords = obj;
          //console.log('everything done',JSON.parse(JSON.stringify(this.oppRecords)));
          //this.accRecords.push(this.oppRecords);
     }
   else if(error)
   {
    console.error(error); 
    }
}
    
handleCancel()
{
    [...this.template
        .querySelectorAll('lightning-input, lightning-combobox')]
        .forEach((input) => { input.value = ''; }); 
}
handleSave()
{
    

    saveOppRecords({oppRecordsApex : this.oppRecords})
    .then(result => {
        //this.istrue = true;
        console.log('created....',result);
        this.dispatchEvent(
            new ShowToastEvent({ 
                title : 'Success',
                message : 'Created Opprtunity Successfully',
                variant : 'Success'
            })
        ); 
    })
        .catch(error => {
            //this.istrue = true;
            console.log('Error: ', error);
        });
       
        [...this.template
            .querySelectorAll('lightning-input, lightning-combobox')]
            .forEach((input) => { input.value = ''; });
        }
    
}