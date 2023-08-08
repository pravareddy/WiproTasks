import { LightningElement,track } from 'lwc';

export default class ChildLWC extends LightningElement {
    @track childValue = '';
    childOnChange(event)
    {
        this.childValue = event.target.value;
        //console.log('childValue>>>>>>'+JSON.stringify(childValue));
        console.log('this.childValue>>>>>>'+JSON.stringify(this.childValue));
    }
    childOnClick(event)
    {
        const childValue = this.childValue;
         //console.log('childValue>>>>>'+childValue);
        const childinput = new CustomEvent('childinput',{
            bubbles : true,
            composed : false,
            detail : childValue
            
        });
       
        this.dispatchEvent(childinput);
    }
}