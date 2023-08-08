import { LightningElement,wire } from 'lwc';
import SAMPLEMC from '@salesforce/messageChannel/messageChannel__c'
import { MessageContext,publish } from 'lightning/messageService'
export default class LmsComponentA extends LightningElement {
    inputValue
    @wire(MessageContext)
    context
    inputHandler(event)
    {
        this.inputValue = event.target.value;
        console.log('this.inputValue>>>>>'+this.inputValue)
    }
    publishHandler()
    {
        const message={
            lmsData:{
                value:this.inputValue
                    }
        }
        publish(this.context,SAMPLEMC,message)
    }
}