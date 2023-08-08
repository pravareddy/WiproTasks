import { LightningElement } from 'lwc';

export default class CreationOf5InAccount extends LightningElement {
//     name
//     accNum
//     annRev
//     phone
//     rating
//     handledChangeName(event)
//     {
//        this.name=event.target.value;
//        console.log('this.name>>>>'+this.name);
//     }
//     handledChangeAccNum(event)
//     {
//         this.accNum=event.target.value;
//         console.log('this.accNum>>>>'+this.accNum);
//     }
//     handledChangeAnnRev(event)
//     {
//         this.annRev=event.target.value;
//         console.log('this.annRev>>>>'+this.annRev);
//     }
//     handledChangePhone(event)
//     {
//         this.phone=event.target.value;
//         console.log('this.phone>>>>'+this.phone); 
//     }
//     handledChangeRating(event)
//     {
//         this.rating = event.target.value;
//         console.log('this.rating>>>>'+this.rating);
//     }
// }


 fields = {};
handledChange(event){
    

            fields.Name = this.template.querySelector("[data-field='AccountName']").value;
            console.log('fields.Name>>>>'+fields.Name);
            fields.AccountNumber = this.template.querySelector("[data-field='AccountNumber']").value;
            console.log('fields.AccountNumber>>>>>'+fields.AccountNumber);
            fields.AnnualRevenue = this.template.querySelector("[data-field='AnnualRevenue']").value;
            console.log('fields.AnnualRevenue>>>>'+fields.AnnualRevenue);
            fields.Phone = this.template.querySelector("[data-field='Phone']").value;
            console.log('fields.Phone>>>>>>'+fields.Phone);
            fields.Rating = this.template.querySelector("[data-field='Rating']").value;
            console.log('fields.Rating>>>>>>>>>>'+fields.Rating);
}
createAccount(event)
{
    saveAccount({accRec :this.fields})
    showNotification()
     {
            const evt = new ShowToastEvent({
            title: AccountSaved,
            message: AccountRecordsSaved,
            variant: sucsess,
             });
            this.dispatchEvent(evt);
     }
}

}