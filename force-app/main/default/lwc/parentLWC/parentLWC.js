import { LightningElement,track} from 'lwc';

export default class ParentLWC extends LightningElement {
    @track valueFromChildLWC = '';
    onChangeParentLWC(event)
    {
        this.valueFromChildLWC = event.detail;
        console.log('this.valueFromChildLWC>>>>>>'+this.valueFromChildLWC);
    }
}