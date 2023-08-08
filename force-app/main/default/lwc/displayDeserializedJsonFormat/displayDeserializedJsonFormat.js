import { LightningElement, wire, track} from 'lwc';
import deserializeJson from '@salesforce/apex/DeserializeJsonFormat.deserializeJson';
export default class DisplayDeserializedJsonFormat extends LightningElement {
   // @wire(deserializeJson) contacts;
   
    @track storeCons;
    @track errorMsg;
    @track showText = false;
    handleClick(event)
    {
        this.showText=true;
        deserializeJson()
        .then(result =>{
        console.log('hi vanakkam');
        console.log('result>>>>>>>'+result);
        this.storeCons=result;
        console.log('this.storeCons>>>>>>>>>>>>>>>'+this.storeCons);
         })
         .catch(error =>{
             this.errorMsg = error;
         })
    }
}