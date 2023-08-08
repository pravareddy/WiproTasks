import { LightningElement } from 'lwc';
import getValues from  '@salesforce/apex/email_SendingApex.getValues';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class Email_SendingLWC extends LightningElement {
    fromValue;
    emailValue;
    ccValue;
    subjectValue;
    mailbodyValue;
    enterValues(event)
    {
      if(event.target.label === "From")
      {
          this.fromValue=event.target.value;
          console.log('this.fromValue>>>>>>>>>'+this.fromValue);
      }
      if(event.target.label === "Email")
      {
          this.emailValue=event.target.value;
          console.log('this.emailValue>>>>>>>>>'+this.emailValue);
      }
      if(event.target.label === "cc")
      {
          this.ccValue=event.target.value;
          console.log('this.ccValue>>>>>>>>>'+this.ccValue);
      }
      if(event.target.label === "Subject")
      {
          this.subjectValue=event.target.value;
          console.log('this.subjectValue>>>>>>>>>'+this.subjectValue);
      }
      if(event.target.label === "Mail body")
      {
          this.mailbodyValue=event.target.value;
          console.log('this.mailbodyValue>>>>>>>>>'+this.mailbodyValue);
      }
    }
    sendValues(event)
    {
        console.log('sendingvaluesssss');
        getValues({fromValue1 : this.fromValue, email : this.emailValue, cc : this.ccValue, subject : this.subjectValue, mailbody : this.mailbodyValue})
        .then(result => {
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
        .querySelectorAll('lightning-input, lightning-input-rich-text')]
        .forEach((input) => { input.value = ''; });
    }
    resetValues(event)
    {
        // this.fromValue=[];
        // this.emailValue=[];
        // this.ccValue=[];
        // this.subjectValue=[];
        // this.mailbodyValue=[];
        // this.template.querySelectorAll("lightning-input").forEach((input) => input.reset());
        [...this.template
            .querySelectorAll('lightning-input, lightning-input-rich-text')]
            .forEach((input) => { input.value = ''; });
    }
}