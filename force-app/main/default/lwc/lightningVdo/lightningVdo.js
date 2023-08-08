import { LightningElement, wire, track} from 'lwc';
import getAccountRecords from '@salesforce/apex/AccountController.getAccountRecords';


export default class LightningVdo extends LightningElement {
    @track data;
    //@track accountRecordsList;
    @track columns = [
        { label: 'Label', fieldName: 'Name', type: 'text' },        
        { label: 'Phone', fieldName: 'Phone', type: 'phone' },
        { label: 'Industry', fieldName: 'Industry', type: 'text' }, 
        { label: 'Rating', fieldName: 'Rating', type: 'text' },      
    ];   
    @wire (getAccountRecords) accountRecords({error,data}){
        if(data){
            this.data = data;            
        }
        else if (error){
            this.data  = undefined;
        }
    }
    // connectedCallback(){
    //     getAccountRecords()
    //         .then(result=>{
    //             this.accountRecordsList = result;
    //         })
    //         .catch(error=>{
    //             this.accountRecordsList = undefined;
    //         });
    // }
}