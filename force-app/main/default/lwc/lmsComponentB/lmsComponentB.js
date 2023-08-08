import { LightningElement,wire } from 'lwc';
import SAMPLEMC from '@salesforce/messageChannel/messageChannel__c'
import { MessageContext,subscribe,APPLICATION_SCOPE } from 'lightning/messageService'

export default class LmsComponentB extends LightningElement {
    @wire(MessageContext)
    context
    receivedMessage
    connectedCallback()
        {
            this.subscribeMessage()
        }
    
    subscribeMessage(){
    subscribe(this.context,SAMPLEMC,(message)=>{this.handleMessage(message)}, {scope:APPLICATION_SCOPE})
    }
    handleMessage(message)
    {
        this.receivedMessage=message.lmsData.value?message.lmsData.value : 'NO Message Published'
        console.log('this.receivedMessage>>>>>>'+this.receivedMessage);
    }
}