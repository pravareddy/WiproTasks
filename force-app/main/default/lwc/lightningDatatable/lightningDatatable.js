import { LightningElement ,wire,track} from 'lwc';
import getAccountRecords from '@salesforce/apex/AccountController.getAccountRecords';
export default class LightningDatatable extends LightningElement {
    @track StoreAccounts;
    @track Columns = [
        
        { label:'Label', fieldName:'Name', type:'text'},
        { label:'Phone', fieldName:'Phone', type:'Phone'},
        { label:'Industry', fieldName:'Indutry', type:'text'},
        { label:'Rating', fieldName:'Rating', type:'text'},
    ];
    @wire(getAccountRecords) accountRecords({error,data}){
        if(data)
        {
            this.StoreAccounts=data;
        }
        else if(error)
        {
            this.StoreAccounts=undefined;
        }
    }
}