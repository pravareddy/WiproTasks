import { LightningElement, api } from 'lwc';
//import ACCOUNT_ID from '@salesforce/account/Id';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_TYPE from '@salesforce/schema/Account.Type';
import ACCOUNT_OWNER from '@salesforce/schema/Account.OwnerId';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';
import ACCOUNT_WEBSITE from '@salesforce/schema/Account.Website';
import ACCOUNT_NUMBER from '@salesforce/schema/Account.AccountNumber';
import ACCOUNT_ANNUAL_REVENUE from '@salesforce/schema/Account.AnnualRevenue';


export default class Detail_Page_Account extends LightningElement {
    @api recordId;
    selectedFields = [ACCOUNT_NAME, 
                      ACCOUNT_TYPE, 
                      ACCOUNT_OWNER,
                      ACCOUNT_PHONE,
                      ACCOUNT_WEBSITE,
                      ACCOUNT_NUMBER,
                      ACCOUNT_ANNUAL_REVENUE];
}