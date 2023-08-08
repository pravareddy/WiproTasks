import { LightningElement, track, wire } from 'lwc';
import disaplyFields from '@salesforce/apex/WrapperToCreateFields.disaplyFields';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import InsertOrders from '@salesforce/apex/WrapperToCreateFields.InsertOrders';
export default class DisplayFieldsInTableFormat extends LightningElement {
  @track objList=[];
  @track error;
  @track isEdit = false;
  //@track rowId;
  //@track saveDraftValues;
  //@track isEdit = false;
//   @wire (disaplyFields)
//   wiredAccounts({data, error})
//   {
//     if(data)
//     {
//         console.log('this.objList>>>>>>>>>>>>++++++++++++++'+JSON.stringify(data));
//         this.objList=data;
//         console.log('this.objList>>>>>>>>>>>>'+JSON.stringify(this.objList));
//         this.error=undefined;
        
//     }
//     else
//     {
//         this.error = error;
//         this.objList=undefined;
//     }
//   }
connectedCallback(){
    disaplyFields().then(result=>{
        this.objList = result;
        this.objList = result.map(ele=>{
            let obj ={...ele, isEdit:false}
        //     console.log('obj>>>>>>>>>>'+obj);
          return obj;
        });
        console.log("check data>>>>>>>"+JSON.stringify(this.objList));
        
    }).catch(error=>{

    })
}
handleSave(event)
{
    /*showToast(){
        const event = new ShowToastEvent({
            title: 'Toast message',
            message: 'Record saved successfully',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }*/
    
    InsertOrders({orderList:this.objList}).then(()=>{
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Record saved sucessfully',
                variant: 'success'
            })
        )
    })
    console.log('this.objList>>>>>>>>>>>>>'+JSON.stringify(this.objList));
    console.log('save button clicked');
    this.saveDraftValues = event.detail.draftValues;
    console.log('this.saveDraftValues>>>>>>>>>>.'+this.saveDraftValues);
        const recordInputs = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });
    

    
}
    
handleEdit(event)
{
   // this.isEdit = true;
    console.log('edit button clicked');
    var rowId = event.currentTarget.dataset.id;
    var Id = event.currentTarget.Id;
    console.log('rowId>>>>>>>>>>'+rowId);
    //let eachOrder = this.objList.find(element =>element.Id === rowId);
    //console.log('eachOrder>>>>>>>>',JSON.stringify(eachOrder.Id));
    let data = this.objList;
    data= data.map(ele=>{
      let obj = ele;
      console.log('obj>>>>>'+obj);
      if(obj.Id === rowId)
      {
          obj.isEdit = true;
      }
    
    return obj;
  })
 //let obj  =data.find(d=>d.Id === rowId );
// obj.isEdit= true;
 //console.log('obj',JSON.stringify(data));
this.display = data;
    //for(Order object : this.objList)
    // {

    // }
    //   let eachOrder = [this.objList];
    //   console.log('eachOrder>>>>>'+eachOrder);
    //   try {
    //     eachOrder = eachOrder.map(data => {
    //        // let obj = Object.create(data);
    //         if(data.Id === rowId){
    //             //console.log('obj ',JSON.stringify(obj));
    //             //obj['isEdit'] = true;
    //             eachOrder.isEdit=true;
    //         }
    //         return obj;
    //     });
    //     console.log(eachOrder);
    //     this.objList = eachOrder;
    // } catch (error) {
    //     console.log('EDIT ERROR: ', error);
    // }
    // let contact = this.contactList.find(ele => ele.Id === rowId);
    // console.log('---------', JSON.parse(JSON.stringify(contact)));
    // console.log('this.contactList',SON.parse(JSON.stringify(this.contactList)));
    
    // console.log('contact.isEdit', contact.isEdit);
      //;
      
}


handleChange(event)
{
    let rowId2 = event.currentTarget.dataset.id;
    console.log('rowId2>>>>>>>>>>'+rowId2);
    //let eachOrder = this.display.find(element =>element.Id === presentId);
    let data = this.objList;
        data= data.map(ele=>{
            let obj = ele;
            if(obj.Id ===rowId)
            {
                obj.isEdit = true;
      console.log('obj>>>>>'+obj);
      if(event.target.label == 'Id')
    {
        obj.Id = event.target.value;
        console.log('obj.Id>>>>>'+obj.Id);
    }
     if(event.target.label == 'Name')
    {
        obj.Name = event.target.value;
        console.log('obj.Name>>>>>'+obj.Name);
    }
    if(event.target.label == 'TypeOfOrder')
    { 
        obj.TypeOfOrder = event.target.value;
        console.log('obj.TypeOfOrder>>>>>'+obj.TypeOfOrder);
    }
    if (event.target.label == 'status')
    { 
        obj.status = event.target.value;
        console.log('obj.status>>>>>'+obj.status);
    }
}
return obj;
})
}
        
handleDelete(event)
{
    
   const deleteId =event.target.dataset.id;;
}
}