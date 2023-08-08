import { LightningElement,track } from 'lwc';
import pubsub from 'c/pubsub'
export default class PubsubComponentB extends LightningElement {
    @track messagevalue
    
 connectedCallback()
 {
     this.callSubscriber()
 }


    callSubscriber()
    {
        pubsub.subscribe('componentA',function(message)
        {
            this.messagevalue = message
        })
        console.log('this.messagevalue>>>>>>>>>'+this.messagevalue);
    }
}