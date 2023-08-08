import { LightningElement ,track,wire} from 'lwc';
import retrieveContact from '@salesforce/apex/fetchAllRelatedRecords.retrieveContact';

export default class DisplayAllRelatedRecords extends LightningElement {
@track currentName;
@track searchName;
handleChangeAccName(event){
this.currentAccountName = event.target.value;
}
handleAccountSearch(){
this.searchName = this.currentName;
}
@track records;
@track dataNotFound;
@wire (retrieveContact,{keySearch:'$searchName'})
wireRecord({data,error}){
if(data){
this.records = data;
this.error = undefined;
this.dataNotFound = '';
if(this.records == ''){
this.dataNotFound = 'There is no Contact found related to Account name';
}
}else{
this.error = error;
this.data=undefined;
}
}
}