import { LightningElement ,track,wire,api} from 'lwc';
import  wrapGettingMetadata from '@salesforce/apex/CSVUploadContactsApex1.wrapGettingMetadata';
export default class ContactsUploadingCSV extends LightningElement {
    //   @track application;
    //   @track csvObject;
      @track csvObjFields=[];
      @track contactList=[];
      @track checkData=[];
      //@track loopCheckedData2=[];
      //@track loopCheckedData1=[];
      @api recordId;
      checkboxVal = false;
      //@track istrue = false;
    //columnHeader = ['ID', 'FirstName', 'LastName', 'Email' ]
    connectedCallback()
    {
       console.log('recordId>>>>>>>>>'+this.recordId);
    }
    @wire(wrapGettingMetadata,  {recId : '$recordId'})
    wiredData({ error, data }) {
        if (data) {
            console.log('metadata');
            console.log('Data>>>>>>>>>>>>>>>>'+data);
            // this.application = data.app;
            // this.csvObject = data.csvFileObj;
            // this.csvObjFields=data.csvFileFieldList;
            // console.log('this.application>>>>>>>'+this.application);
            // console.log('this.csvObject>>>>>>>>>'+this.csvObject);
            this.csvObjFields=data.csvFileFieldList;
          //   for(var i=0; i<=this.csvObjFields.length; i++)
          // {
          //   console.log('i+++++'+i);
          //   console.log('this.csvObjFields[i].Name>>>>>>>>>>>>>>>>>>>>'+this.csvObjFields[i].Name);
          //   //let file=this.checkData[i];
          //   //console.log('file>>>>>>>>>>>>.'+file);
          //   this.loopCheckedData1 = this.csvObjFields[i].Name;
          //   console.log('this.loopCheckedData1>>>>>>>>>>>>>>>>>>>>>>>'+this.loopCheckedData1);
          // }
          //   this.csvObjFields = this.csvObjFields.replace(/,/g, ""); // remove commas
          // this.csvObjFields = parseFloat(this.csvObjFields); // now parse to float should always be clean input
        
            this.contactList=data.con1;
            console.log('this.contactList>>>>>>>>>>'+this.contactList);
             //onsole.log('this.loopCheckedData1>>>>>>>>>>>>>>>>>>>>>>>'+this.loopCheckedData1);
           console.log('this.contactList>>>>>>>>>>'+JSON.stringify(this.contactList));
            console.log('this.csvObjFields>>>>>>>>'+JSON.stringify(this.csvObjFields));
        } else if (error) {
            console.error('Error:', error);
        }
    }
    handleChange(event)
      {
        if (event.target.checked)
        {
          console.log('Check box is checked');
          this.checkData=this.contactList;
          console.log('this.checkData>>>>>>>>>>'+this.checkData); 
         // console.log('looping starts');
          //event.target.files = this.checkData;
          // this.checkData = this.checkData.replace(/,/g, ""); // remove commas
          // this.checkData = parseFloat(this.checkData); // now parse to float should always be clean input
        
        //  console.log('this.checkData.length>>>>>>>>>>'+this.checkData.length);
        //  console.log('this.checkData[0].name>>>>>>>>>>'+this.checkData.name);
        //   for(var j=0; j<=this.checkData.length; j++)
        //   {
        //     console.log('j+++++'+j);
        //     //let file=this.checkData[i];
        //     //console.log('file>>>>>>>>>>>>.'+file);
        //     this.loopCheckedData2 = this.checkData[j].name;
        //   }
          
          
        //   console.log('looooping');
        //   console.log('this.loopCheckedData2>>>>>>>>>>'+this.loopCheckedData2);
        }
        else 
        {
          checkData='';
          console.log('check box is unchecked');
        }
        console.log('this.checkData>>>>>>>>>>'+JSON.stringify(this.checkData));
     }

     handleDownloadingCSV(){
      // Prepare a html table
      let doc = '<table>';
      // Add styles for the table
       doc += '<style>';
       doc += 'table, th, td {';
       doc += '    border: 1px solid black;';
       doc += '    border-collapse: collapse;';
       doc += '}';          
       doc += '</style>';
      // Add all the Table Headers
      doc += '<tr>';
      this.csvObjFields.forEach(element1 => {            
          doc += '<th>'+ element1 +'</th>'           
      });
      doc += '</tr>';
      // Add the data rows
      this.conatctData.forEach(record => {
        var storeRecords = [];
        storeRecords=this.checkData;
          doc += '<tr>';
          doc += '<th>'+record.storeRecords[0]+'</th>'; 
          doc += '<th>'+record.storeRecords[1]+'</th>'; 
          doc += '<th>'+record.storeRecords[2]+'</th>';
          doc += '<th>'+record.storeRecords[3]+'</th>'; 
          doc += '</tr>';
      });
      doc += '</table>';
      var element = 'data:application/vnd.ms-excel,' + encodeURIComponent(doc);
      let downloadElement = document.createElement('a');
      downloadElement.href = element;
      downloadElement.target = '_self';
      // use .csv as extension on below line if you want to export data as csv
      downloadElement.download = 'Contact Data.xls';
      document.body.appendChild(downloadElement);
      downloadElement.click();
  }

    // handleDownloadingCSV(event)
    // {
    //   var element = 'data:application/vnd.ms-excel,' //+ encodeURIComponent(doc);
    //     let downloadElement = document.createElement('a');
    //     downloadElement.href = element+this.csvObjFields+this.checkData;
    //     downloadElement.target = '_self';
    //     // use .csv as extension on below line if you want to export data as csv
    //     downloadElement.download = 'Contact Data.xls';
    //     document.body.appendChild(downloadElement);
    //     downloadElement.click();
    // }
}