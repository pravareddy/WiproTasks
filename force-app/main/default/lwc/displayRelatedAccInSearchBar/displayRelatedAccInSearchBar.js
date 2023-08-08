import { LightningElement, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/DisplayRelatedAccInSearchBar.getContacts'
export default class DisplayRelatedAccInSearchBar extends LightningElement {
    @track accountName;
    //@track currentName;
    @track searchName;
    @track StoreContacts;
    
    handleChangeAccName(event){
        this.accountName = event.target.value;
        console.log('this.accountName>>>>>>>>>>>>>>>'+this.accountName);

    }
    handleAccountSearch()
    {
        this.searchName=this.accountName;
        console.log('this.searchName>>>>>>>>'+this.searchName);
    
    }
    @wire(getContacts,{accName:'$searchName'})
    wiredContacts({error,data})
    {
        if(data)
        {
            console.log('data>>>>>>>'+JSON.stringify(data));
            this.StoreContacts=data;
            console.log('this.StoreContacts>>>>>>>>>>>>'+JSON.stringify(this.StoreContacts));
            if(this.records == ''){
                this.dataNotFound = 'There is no Contact found related to Account name';
                }
        }
        else
        {
            this.error = error;
            this.data=undefined;
            console.log('error');
        }
    }
}