import { LightningElement , track, wire,api} from 'lwc';
import sendOtpByEmail from "@salesforce/apex/sendOtpThroughEmail.sendOtpByEmail";
export default class UpdateEmail extends LightningElement {
    @api recordId;
    step = 1;
    currentStep = "1";
    showSpinner;
    showUpdateEmailAddress=true;
    showVerifyEmailAddress=false;
    sentCodeToVerifyEmailAddress=false;
    skipVerficationPage=false;
    showComplete=false;
    @track storeEmailAdd;
    @track contacts;
    @track error;
    @track phoneNumber;
    @track splitPhoneNo;
    @track splitDate;
    @track splitMonth;
    @track generatingOTP;
    @track userEnteredOTP;
    @track inputvalue;
    @track Buttontrue=true;
   
    
   
    getCodeSent()
    {
        console.log('true');
        this.sentCodeToVerifyEmailAddress=true;
        console.log('code has been sent');
    }
    Continue(event) {
       
      // this.storeEmailAdd=event.target.value;
      this.storeEmailAdd = this.template.querySelector('lightning-input').value;
       console.log('this.storeEmailAdd>>>>>>>>>>>>>>>>>'+this.storeEmailAdd);
        if (this.step != 3) {
            this.step++;
        }

        this.handleSetUpSteps();
    }
    
    
    handleSetUpSteps(){
        this.showUpdateEmailAddress=this.step ==1;
        this.showVerifyEmailAddress=this.step==2;
        this.showComplete=this.step==3;
        this.currentStep = "" + this.step;

        if (this.step = 2) {
            showVerifyEmailAddress=true;
        }
    
    }
    sendCode(event)
    {
        console.log("fullDate");
        let date = new Date()
        console.log('date>>>>>>>>>>'+date);
        let time = date.getTime();
        console.log('time>>>>>>>>>>>'+time);
        let currentHours = date.getHours();
        console.log('currentHours>>>>>>>>>'+currentHours);
        let currentMinutes = date.getMinutes();
        console.log('currentMinutes>>>>>>>>>>>>>>>'+currentMinutes);
        let currentSec = date.getSeconds();
        console.log('currentSec>>>>>>>>>>>>..'+currentSec);
        let day = date.getDate();
        let month = date.getMonth()+1;
        let year = date.getFullYear();
        let fullDate = `${day}.${month}.${year}.`;
        console.log(fullDate);
         this.splitDate=fullDate.split('.')[0];
         this.splitMonth=fullDate.split('.')[1];
         console.log('this.splitDate>>>>>>>>>>>>>>>'+this.splitDate);
         console.log('this.splitMonth>>>>>>>>>..'+this.splitMonth);
         this.generatingOTP=this.splitDate+this.splitMonth+currentMinutes+currentSec;
         console.log('this.generatingOTP>>>>>>>>>>>>>>>>>'+this.generatingOTP);
         console.log('sendOtpByEmail');
        //console.log('generatingOTP>>>>>>>>>>>>>>>>>>>>'+generatingOTP);
        sendOtpByEmail({
            userEmail:this.storeEmailAdd,
            otp:this.generatingOTP
        })
        //showVerifyEmailAddress=true;
        if (this.step = 2) {
            this.sentCodeToVerifyEmailAddress=true;
            this.showVerifyEmailAddress=false;
            console.log('send code event with the step2');
            this.getCodeSent();
            console.log('after method');
        }
        
    }
    skipVerification(event) {
               this.skipVerficationPage=true;
                this.showVerifyEmailAddress=false;
                
                if (this.step != 3) {
                    this.step++;
                }
        
                this.handleSetUpSteps();
           
            
    }
    handleChange(event){
        this.inputvalue = event.target.value;
        console.log('this.inputvalue>>>>>>>>>>>>>>>>>>>>>>',this.inputvalue);
        if(this.inputvalue > 0){
            this.Buttontrue=false;
        }
    }
    

    verifyCode(event)
    {
        this.userEnteredOTP=this.template.querySelector('lightning-input').value;
        
        console.log('this.userEnteredOTP>>>>>>>>>>>>>>>>>>>.'+this.userEnteredOTP);

        if(this.userEnteredOTP===this.generatingOTP)
        {
            if (this.step = 3) {
                this.sentCodeToVerifyEmailAddress=false;
                this.showComplete=true
                

            }
        }
        if (this.step != 3) {
            this.step++;
        }

        this.handleSetUpSteps();
    }
    
    


    
}