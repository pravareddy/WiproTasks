import { LightningElement,wire, api, track} from 'lwc';
import getContacts from '@salesforce/apex/SendEmail_Apex.getContacts';
import getValues_EmailTemplate from '@salesforce/apex/SendEmail_Apex.getValues_EmailTemplate';
//import getIdFromEmailTemp from '@salesforce/apex/SendEmail_Apex.getIdFromEmailTemp';
import sendEmail from '@salesforce/apex/SendEmail_Apex.sendEmail';
import sendEmail2 from '@salesforce/apex/SendEmail_Apex.sendEmail2';
import getLastName from '@salesforce/apex/SendEmail_Apex.getLastName';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';


export default class SendEmail_LWC extends LightningElement {
//Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
@track isModalOpen = false;
@track valuesFromPopUp;
@track storeSubjBody=[];
@track storeEmail=[];
@track storeSubject;
@track storeBody;
@track LastName ='';
@track accountContacts=[];
@track emailTemplates=[];
//@track restoreEmailTemp=[];
//@track emailrecordName='';
@api recordId;
// @track fromValue;
@track idForEmail;
openModal() {
    // to open modal set isModalOpen tarck value as true
    this.isModalOpen = true;
}
closeModal() {
    // to close modal set isModalOpen tarck value as false
    this.isModalOpen = false;
}
submitDetails() {
    // to close modal set isModalOpen tarck value as false
    //Add your code to call apex method or do some processing
    this.isModalOpen = false;
    
}
handleChange(event)
{
    // if(event.target.label === "From Address")
    //   {
    //       this.fromValue=event.target.value;
    //       console.log('this.fromValue>>>>>>>>>'+this.fromValue);
    //   }
    this.LastName=event.target.value;
    console.log('this.LastName>>>>>>>>>>>>>>>>'+this.LastName);
    getLastName({storeLName:this.LastName})
    .then(result => {
        console.log('Result ==> ', result);
        this.storeEmail=result;
        console.log('this.storeEmail>>>>>>>>>>>>'+JSON.stringify(this.storeEmail));
    });
    // this.idForEmail = event.currentTarget.dataset.id;
    // console.log('this.idForEmail >>>>>>>>>>>>>>'+this.idForEmail);
    // console.log('search keyword');
    // console.log('this.ContactName>>>>>>>>>>>>>'+this.ContactName);
}
handleRadio(event)
{
    this.valuesFromPopUp = event.currentTarget.dataset.id;
    console.log('submittted values');
    console.log('this.valuesFromPopUp>>>>>>>>>>>>'+this.valuesFromPopUp);
    // getIdFromEmailTemp({emailTempId:this.valuesFromPopUp})
    // .then(result => {
    //     console.log('Result ==> ', result);
    //     console.log('result.Subject>>>>>>>>>'+result.Subject);
    //     console.log('result.Body >>>>>>>>'+result.Body);
    //     this.storeSubjBody=result;
    //     this.storeSubject=result.Subject;
    //     this.storeBody=result.Body;
    console.log('this.LastName>>>>>>>>>>>>'+this.LastName);
    sendEmail2({templateId1:this.valuesFromPopUp, storeLName1:this.LastName })
    .then(result => {
            console.log('Result ==> ', result);
            //console.log('result.Subject>>>>>>>>>'+result.Subject);
             //console.log('result.Body >>>>>>>>'+result.Body);
            this.storeSubjBody=result;
           this.storeSubject=result.emailSubject1;
            this.storeBody=result.emailBody1;
        
        console.log('this.storeSubject>>>>>>>>>>>>>'+JSON.stringify(this.storeSubject));
        console.log('this.storeBody>>>>>>>>>>>>>'+JSON.stringify(this.storeBody));
    })
        //console.log('this.storeSubjBody>>>>>>>>>>>>>'+JSON.stringify(this.storeSubjBody.Body));
    
    
}
// @wire(getIdFromEmailTemp,{emailTempId: this.valuesFromPopUp})
// wiredContacts({error,data})
// {
//     if(data)
//      {  
//          this.storeSubjBody = data;
//          console.log('data>>>>>>>>>>>'+data);
//          console.log('getting only subject and body');
//          console.log('this.storeSubjBody>>>>>>>>>>>>'+JSON.stringify(this.storeSubjBody));
//         console.log('data>>'+JSON.stringify(data));
//      }
//    else if(error)
//    {
//     console.error(error); 
//     }
// }



    //console.log('email template');
//  @track currentName;
// @track searchName;
// handleChangeConName(event){
// this.currentContactName = event.target.value;
// console.log('this.currentContactName>>>>>>>>>>>>>'+this.currentContactName);
// }
// handleContactSearch(){
// this.searchName = this.currentName;
// console.log('this.searchName>>>>>'+this.searchName);
// }

// @wire(getContacts, {recId : '$recordId'})
// wiredContacts({error,data})
// {
//     if(data)
//      {  
//          this.accountContacts = data;
//          console.log('data>>>>>>>>>>>'+data);
//          console.log('getting contacts');
//          console.log('this.accountContacts>>>>>>>>>>>>'+JSON.stringify(this.accountContacts));
//         console.log('data>>'+JSON.stringify(data));
//      }
//    else if(error)
//    {
//     console.error(error); 
//     }
// }

@wire(getValues_EmailTemplate)
wiredContacts({error,data})
{
    if(data)
     {  
         this.emailTemplates = data;
         console.log('data>>>>>>>>>>>'+data);
         console.log('getting email templates');
         console.log('this.emailTemplates>>>>>>>>>>>>'+JSON.stringify(this.emailTemplates));
        console.log('data>>'+JSON.stringify(data));
     }
   else if(error)
   {
    console.error(error); 
    }
}
// handleEmailTemp(event)
// {
//   this.restoreEmailTemp = this.emailTemplates;
//   console.log('handleEmailTemplateButton');
//   console.log('this.restoreEmailTemp>>>>>>>>>>'+this.restoreEmailTemp);
// }

connectedCallback(){
    getContacts({recId : this.recordId})
    .then(result => {
        console.log('Result ==> ', result);
        //this.storeEmail=result.email;
       // console.log('result.email>>>>>>.'+result.email);
        //console.log('this.storeEmail>>>>>>>>>>>>>'+this.storeEmail);
        let opt = [];
        result.forEach(ele => {
            opt.push({
                label : ele.LastName,
                value : ele.LastName
            })
        })
        this.accountContacts = opt;
        // this.storeEmail=this.accountContacts.email;
        // console.log('this.storeEmail>>>>>>>.'+this.storeEmail);
        console.log('Acc.Con Details --> ',this.accountContacts);
    })
}

        



sendingEmail(event)
{
    console.log('sending an email');
    console.log('this.valuesFromPopUp>>>>>>>>>>>.'+this.valuesFromPopUp);
    console.log('this.LastName>>>>>>>>'+this.LastName);
    sendEmail({Subject1:this.storeSubject, 
               Body:this.storeBody, 
               storeLName1:this.LastName, 
               templateId:this.valuesFromPopUp
               })
        .then(result => {
            // console.log('result in sending email>>>>>>>>>.'+result);
                this.dispatchEvent(
                    new ShowToastEvent({ 
                        title : 'Success',
                        message : 'Email sent Sucessfully',
                        variant : 'Success'
    
    
                    })
                );
            })
        
        .catch(error => {
            console.log('error in saving',error);
        });
        [...this.template
            .querySelectorAll('lightning-input, lightning-input-rich-text, lightning-combobox')]
            .forEach((input) => { input.value = ''; }); 
        }
}