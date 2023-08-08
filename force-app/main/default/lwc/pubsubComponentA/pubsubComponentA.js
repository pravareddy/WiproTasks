import { LightningElement,track } from 'lwc';
import pubsub from 'c/pubsub'
export default class PubsubComponentA extends LightningElement {
   @track message
    inputHandler(event)
    {
        this.message=event.target.value
        console.log('this.message>>>>'+this.message);
    }
    publishHandler(event)
    {
      pubsub.publish('componentA',this.message)
    }
}