import { LightningElement,track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/displayAccRecInTableToViewInPopUp.getAccounts';
import getSingleAccount from '@salesforce/apex/displayAccRecInTableToViewInPopUp.getSingleAccount';
export default class DisplayAccRecInTableToViewInPopUp extends LightningElement {
@track singleAccRecords;  
@track rowId;
@track storeAccRecords;
@track isShowModal = false;
//@track currentId;
//@track presenttId;
//@track rowId1;
@wire(getAccounts)
wiredAccounts({error,data})
{
if(data)
{
    console.log('data>>>>>>>>>>'+JSON.stringify(data));
    this.storeAccRecords=data;
    console.log('this.storeAccRecords>>>>>>>>>>>>>>>'+JSON.stringify(this.storeAccRecords));
}
else if(error)
{
  console.log('error>>>>>>>>>>>>>'+error);
}

}

// handleView(event)
// {
//    //this.rowId = event.target.dataset.recordId;
//    //console.log('this.rowId>>>>>>>>'+this.rowId);
//   this.rowId = event.currentTarget.row.id;
//   this.currentId = event.target.dataset.id;
//   console.log('this.rowId>>>>>>>>'+this.rowId);
//   console.log('this.currentId>>>>>>>>'+this.currentId);
//   //this.presenttId = event.target.dataset.recordId;
//  // console.log('this.presenttId>>>>>>>>'+this.presenttId);
//   //this.rowId1 = event.detail.row.Id;
//   //console.log('this.rowId1>>>>>>>>'+this.rowId1);
//   //console.log(event.target.dataset.recordId); 


// }
showModalBox(event)
{
  this.isShowModal = true;
  console.log('on clicking');
  //this.rowId = event.currentTarget.row.id;
  //console.log('this.rowId>>>>>>>>'+this.rowId);
  this.rowId = event.currentTarget.dataset.id;
   console.log('this.rowId>>>>>>>>'+this.rowId);
  console.log('done clicking');
  getSingleAccount({accId:this.rowId})
.then(result => {
  console.log('result>>>>>>>>>>>'+JSON.stringify(result));
  this.singleAccRecords=JSON.stringify(result);
  console.log('this.singleAccRecords>>>>>>>>>>>>>>>'+this.singleAccRecords);
})
}
hideModalBox() {  
  this.isShowModal = false;
}



// accountInfo({error,data})
// {
// if(data)
// {
//     console.log('data is coming from apex');
//     this.singleAccRecords = data;
//     console.log('this.singleAccRecords>>>>>>>>>>>')
// }
// else if(error)
// {
//     console.error('ERRor', 'error');
// }
// }



//Modal Pop Up





}