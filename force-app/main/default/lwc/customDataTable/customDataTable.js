import { LightningElement,track,wire,api } from 'lwc';
import gettingContacts from '@salesforce/apex/CustomDataTableApex.gettingContacts';
import updatingContacts from '@salesforce/apex/CustomDataTableApex.updatingContacts';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';
import {NavigationMixin} from 'lightning/navigation';
export default class CustomDataTable extends LightningElement {
  @api recordId;
  //@track contacts;
  @track allContacts = []
  @track isEdit = false;
  @track isChanged = false;
  @track isSave = false;
  @track  renderTable = false;
//   @wire (gettingContacts) 
//   getContacts({data,error})
//   {
//       console.log('hiiiiii');
//       console.log('data>>>>>'+data);
//       if(data)
//       {
//           console.log('data>>>>'+JSON.stringify(data));
//           this.contacts = data;
//           console.log('this.contacts>>>>'+JSON.stringify(this.contacts));
//       }
//       else if(error)
//       { 
//           this.error = error;
//           console.error('this.error');
//       }
//   }

// to call the apex method in the apex class and give the current record Id to(recId)
  connectedCallback()
 {
       console.log('hiiiiiiii');
      gettingContacts({recId : this.recordId})
    .then(result=> {
       // console.log('result>>>>>>'+result);
       var conList = []
        result.forEach(element=>{
        var con = {};
                con.Id           =        element.Id;
                con.FirstName    =       element.FirstName;
                con.LastName     =       element.LastName;
                con.Phone        =       element.Phone;
                con.Email        =       element.Email;
                con.isEdit       =        false;
                con.isChanged     =       false;
                if(this.allContacts.length === 0)
                {
                     this.renderTable = false;
                }
                else{
                    this.renderTable = true;
                }
                conList.push(con);
                System.debug('conList>>>>>>>'+conList);

                
            })
        
        console.log('result>>>>>>'+result);
        //this.contacts=result;
        console.log('this.allContacts>>>>'+JSON.stringify(this.allContacts));
     })  
      
 }

 //enable to do edit when we click on edit symbol
 tryingToEdit(event)
 {
    //console.log('wwwwwwwwwwwwwwwwwwwwwwwwwwwww');
      var presentId = event.currentTarget.dataset.id;
      console.log('presentId>>>>>>'+presentId);
      //this.currentId = presentId;
      console.log('this.currentId>>>>>'+this.currentId);
      let eachContact = this.display.find(element =>element.Id === presentId);
      console.log('eachContact>>>>>'+eachContact);
      eachContact.isEdit = false;
 }
 //to store the changed values in the current array
 handleChange(event)
 {
     var currentId = event.target.dataset.id;
    let eachContact = this.display.find(element =>element.Id === currentId);
    this.isSave = true;
    console.log('eachContact>>>>>'+JSON.stringify(eachContact));
    if(event.target.label == 'FirstName')
    {
        eachContact.FirstName = event.target.value;
        console.log('eachContact.FirstName>>>>>'+eachContact.FirstName);
    }
    else if(event.target.label == 'LastName')
    {
          eachContact.LastName = event.target.value;
    }
    else if(event.target.label == 'Email')
    { 
        eachContact.Email = event.target.value;
    }
    else (event.target.label == 'Phone')
    { 
        eachContact.Phone = event.target.value;
    }
    eachContact.isChanged = true;
 }
 handleSave(event)
 {
     var changedData = [];
     this.allContacts.forEach(element=>{ 
      var contact = {};
               contact.Id           =        element.Id;
                contact.FirstName    =       element.FirstName;
                contact.LastName     =       element.LastName;
                contact.Phone        =       element.Phone;
                contact.Email        =       element.Email;
                changedData.push(contact);
         
     }
                              );
        if(changedData.length>0)
        { 
            updatingContacts({conList :changedData})
            .then(result =>{ 
                this.dispatchEvent(
                    new ShowToastEvent({ 
                        title : 'Success',
                        message : 'Record Saved Sucessfully',
                        variant : 'Success'


                    })
                );
            })
        
        .catch(error => {
            console.log('error in saving',error);
        });
    }

 }
 handleDelete(event){ 
     var deleteId = event.target.dataset.id;
     deleteRecord(deleteId)
     .then(result =>{ 
        this.dispatchEvent(
            new ShowToastEvent({ 
                title : 'Success',
                message : 'Record Saved Sucessfully',
                variant : 'Success'


            })
        );
        var singleRecord = this.allContacts.find(contact => (contact.Id === deleteId));
        this.allContacts.splice(singleRecord, 1)
     })
     .catch(error => {
        console.log('error in saving',error);
    });
 }
 handleCancel(event)
 { 
     this.allContacts.forEach(element =>{ 
         element.isEdit=false;
     })
     this.isSave = false;
     this.connectedCallback();
 }
 handleHyperLink(event)
 {
     var conId = event.target.dataset.id;
     this[NavigationMixin.Navigate]({ 
         type:'standard_recordPage',
         attributes: {
             objectApiName : 'Contact',
             recordId : conId,
             actionName:'view',
         },
     });
 }
}