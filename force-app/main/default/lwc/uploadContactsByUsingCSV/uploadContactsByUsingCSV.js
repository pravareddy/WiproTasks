import { LightningElement, api, track, wire} from 'lwc';
import gettingContacts from '@salesforce/apex/UploadContactsByUsingCSVApex.gettingContacts';
import getCSVDownloadLink from '@salesforce/apex/UploadContactsByUsingCSVApex.getCSVDownloadLink';
export default class UploadContactsByUsingCSV extends LightningElement 
{

 @api recordId;
 @track storeContacts = [];
 @track errorMessage;
 @track FirstName;
 @track LastName;
 @track Phone;
 @track Email;
 @track downloadCSVFile;
 @track ShowErrorToastMessage;
  CSVDownloadLink;
//  handleChange()
//  {
//     connectedCallback()
//     {
//      console.log('recordId>>>>>>>>>'+this.recordId);
//      gettingContacts({recId:'$recordId'})
//      .then(result => {
//         console.log('getting valuess');
//          console.log('data>>>>>>>>>>>>>>'+result);
//          this.storeContacts = result;
//      })
//      .catch(error => {
//         console.log(error);
//      });
//     }
//  }
//handleDownloadingCSV(event){
   // console.log('getting');
// @wire(gettingContacts, {recId :'$recordId'})
// wiredContacts({data,error})
// {
//     if(data)
//     {    
//         console.log('hiiiiiiiiiiiiiiiiiiiiiii');
//         console.log('data>>>>>>>>>>>>>>'+JSON.stringify(data));
//         this.storeContacts = data;
//         this.CSVDownloadLink = data;
//         this.errorMessage = undefined;
//         console.log(' this.storeContacts>>>>>>>>>>'+JSON.stringify(this.storeContacts));
//     }
//     else if(error)
//     {
//         this.errorMessage = error;
//         this.storeContacts = undefined;
//         console.error(error);
//     }
// }
//}
handleToDownload(event)
 {
    let contactData = this.template.querySelector("lightning-input[data-lastName='data']")
    if(this.LastName != null && contactData && contactData.checked)
    {
        getCSVDownloadLink({FirstName:this.FirstName, LastName:this.LastName, Phone:this.Phone, Email:this.Email, recordId:this.recordId})
        .then(result=>{
            this.downloadCSVFile(result, 'uploadingTemplate.csv');
            console.log('result>>>>>>>>>>>'+result);
        })
        .catch(error=> {
            this.ShowErrorToastMessage(error);

        });


    }
    else
    {
        this.downloadCSVFile(this.templateCSVText, 'uploadingTemplate.csv');
    }
    
}
    // handleToDownload(event)
    // {
    // @wire(getCSVDownloadLink, {recId :'$recordId'})
    //   wiredCon({data,error})
    //   {
    //     if(data)
    //      {    
    //         console.log('hiiiiiiiiiiiiiiiiiiiiiii');
    //         console.log('data>>>>>>>>>>>>>>'+JSON.stringify(data));
    //         this.CSVDownloadLink = data;    //         this.errorMessage=undefined;
    //         console.log(' this.CSVDownloadLink>>>>>>>>>>'+JSON.stringify(this.CSVDownloadLink));
    //      }
    //     else if(error)
    //      {
    //      this.errorMessage = error;
    //      this.this.CSVDownloadLink=undefined;
    //      console.error(error);
    //      }
    //  }
    // }
    handleDownloadingCSV(event)
    {
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
        this.columnHeader.forEach(element => {            
            doc += '<th>'+ element +'</th>'           
        });
        doc += '</tr>';
        // Add the data rows
        this.conatctData.forEach(record => {
            doc += '<tr>';
            doc += '<th>'+record.Id+'</th>'; 
            doc += '<th>'+record.FirstName+'</th>'; 
            doc += '<th>'+record.LastName+'</th>';
            doc += '<th>'+record.Email+'</th>'; 
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
    }