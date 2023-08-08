import { LightningElement, wire} from 'lwc';
import {publish,MessageContext} from 'lightning/messageService';
import COUNT_UPDATED_CHANNEL from '@salesforce/messageChannel/Count_Updated__c';

export default class RemoteControl extends LightningElement {
@wire(MessageContext) messageContext;

handleIncrement()
{
    const payload = { 
        //this.counter++
        operator:'add',
        constant:1
    };
    publish(this.messageContext,COUNT_UPDATED_CHANNEL,payload);
}

handleDecrement()
{
    const payload = {
        //this.counter--  
        operator:'subtract',
        constant:1
    };
    publish(this.messageContext,COUNT_UPDATED_CHANNEL,payload)
}

handleMultiply()
{
    const payload = {
        //this.counter***
        operator:'multiply',
        constant:1
    };
    publish(this.messageContext,COUNT_UPDATED_CHANNEL,payload)
}
}