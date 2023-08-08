import { LightningElement,track, wire ,api} from 'lwc';
import sendNotificationRecords from '@salesforce/apex/NotificationsInAccountTab_T.sendNotificationRecords';
const columns=[
    {
        label:"type",
        fieldName:"Text"

    },
    {
        label:"subject",
        fieldName:"Long Text" 
    },
    {
        label:"Message",
        fieldName:"Long Text" 
    },
    {
        label:"ToAddress",
        fieldName:"Text" 
    },
    {
        label:"CreatedTime",
        fieldName:"Date" 
    }
    
];
export default class DisplayNotificationsInAccountTab extends LightningElement {
   
@wire (sendNotificationRecords) sendRecords;

contacts;
    error;

    @wire(sendNotificationRecords)
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            console.log('this.contacts>>>>>>>>>>>>>>'+this.contacts);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    }
    
@track columnss=columns;
@track data=[]; //stored for table
@track items=[]; //contains all records
@track startingRecord = 1;
 page = 1;
@track endingRecord=0;
@track totalRecordCount; //total records count
@track totalPage; //divided to how many pages
@track pageSize=5;
@track error;
@track buttonValue=true;

@wire(sendNotificationRecords) fetchNotifications(result){
    //console.log('sendRecords>>>>>>>>>>>>.'+sendRecords);
    if(result.data){
        //item stores all records
        this.items= result.data;
        console.log('hey');
        console.log('result.data>>>>>>>>.'+result.data);
        console.log('result.data>>>>>>>>>>>.'+JSON.stringify(result.data)); 
        console.log('this.items>>>>>>>>>>>>'+this.items);
        //total records count
        this.totalRecordCount=result.data.length;
        //total page count from Math.ceil which counts next largest integer example : math.ceil(7.04) = 8 is next largest 
        this.totalPage=Math.ceil(this.totalRecordCount/this.pageSize);
        //slice method takes 2 params (includive 0 and exclusive pagesize)
        this.data=JSON.stringify(this.items.slice(0,this.pageSize));
        console.log('this.data>>>>>>>>>>>>>'+this.data);
        this.endingRecord=this.pageSize;
    }
}

//onclick of previous method this meyhod gets called
preHandler(event){
    let test = this.template.querySelector('lightning-button');
    if(this.page > 1){
        this.page = this.page - 1;
        this.displayRecordPerPage(this.page);
    }
    if(this.page<=0)
    {
        this.buttonValue=false;
    }
}
//onclick pf next method this method will called
nextHandler(event){
    if(this.page <this.totalPage && this.page !==this.totalPage){
        this.page=this.page+1;
        this.displayRecordPerPage(this.page);
    }
}
displayRecordPerPage(page){
    this.startingRecord = (page - 1)*this.pageSize;
    this.endingRecord = page*this.pageSize;
    this.endingRecord = (this.endingRecord > this.totalRecordCount)?this.totalRecordCount:this.endingRecord;
    this.data=this.items.slice(this.startingRecord,this.endingRecord);
    this.startingRecord=this.startingRecord+1;
}
}