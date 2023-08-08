import { LightningElement, wire, api, track} from 'lwc';
import getAllConFromAccount from '@salesforce/apex/IsContactsPresentInAccountApex.getAllConFromAccount';
//import { NavigationMixin } from 'lightning/navigation';
export default class IsContactsPresentInAccountLWC extends LightningElement {
    @api recordId;
    @track gettingContacts=[];
    @track errorMessage;
    @track storeContacts=[];
    // showListOfContacts(event)
    // {

    // }
    // createAContact(event)
    // {

    // }ID --> 
    connectedCallback()
    {
        console.log('RECORDID --> ', this.recordId);
    }
    @wire(getAllConFromAccount, {recId :'$recordId'})
    wiredContacts({data,error})
    {
        if(data)
        {    
            console.log('hiiiiiiiiiiiiiiiiiiiiiii');
            console.log('data>>>>>>>>>>>>>>'+JSON.stringify(data));
            this.gettingContacts = data;
            this.errorMessage=undefined;
            console.log(' this.gettingContacts>>>>>>>>>>'+JSON.stringify(this.gettingContacts));
        }
        else if(error)
        {
            this.errorMessage = error;
            this.gettingContacts=undefined;
            console.error(error);
        }
    }
    contactInfo(event)
    {
            if(event.target.label === "FirstName")
              {
                this.storeContacts.FirstName = event.target.value;
                console.log('this.storeContacts.FirstName>>>>>>>>'+this.storeContacts.FirstName);
              }
              else if(event.target.label === "LastName")
              {
                  this.storeConatcts.LastName = event.target.value;
                  console.log('this.storeContacts.LastName>>>>>>>>'+this.storeContacts.LastName);
              }
              else if(event.target.label === "Phone")
              {
                  this.storeContacts.Phone === event.target.value;
                  console.log('this.storeContacts.Phone>>>'+this.storeContacts.Phone);
              }
              else if(event.target.label === "Email")
              {
                this.storeContacts.Email === event.target.value;
                console.log('this.storeContacts.Email>>>'+this.storeContacts.Email); 
              }
              else if(event.target.label === "Department")
              {
                this.storeContacts.Department === event.target.value;
                console.log('this.storeContacts.Department>>>'+this.storeContacts.Department); 
              }
   }
   createContact(event)
   {
       
   }

}