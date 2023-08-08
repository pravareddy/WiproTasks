import { LightningElement, track, api} from 'lwc';
import getListOfAccounts from '@salesforce/apex/AccountController.getListOfAccounts';
export default class DataTableVdoPractice_Lwc extends LightningElement {
@track storeAccounts;
@api recordId;
connectedCallback()
{
    console.log('recordId>>>>>>>>>>>>'+ recordId);
}
}