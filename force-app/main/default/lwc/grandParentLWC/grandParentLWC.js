import { LightningElement } from 'lwc';

export default class GrandParentLWC extends LightningElement {
    valueFromParent = '';
    onGrandParentLWC(event)
    {
       this.valueFromParent=event.detail;
       console.log('this.valueFromParent>>>>'+this.valueFromParent);
    }
}