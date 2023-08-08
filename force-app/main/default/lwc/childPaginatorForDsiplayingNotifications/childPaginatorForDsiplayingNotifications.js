import { LightningElement,track,api } from 'lwc';

export default class ChildPaginatorForDsiplayingNotifications extends LightningElement {

   @api pageCountFromParent=[];
   @api totalPageCountFromParent=[];
   disablePrevButton=false;
   disableNextButton=false;
   //@track ButtonValue;
   //ButtonValue()
   //{
   //  return (this.pageCountFromParent===1);
   //}
   connectedCallback(){
    if(this.pageCountFromParent==1)
       {
        console.log('this.pageCountFromParent>>>>>>>>>>>>'+this.pageCountFromParent);
        this.disablePrevButton=true;
       }
   }
   
   //onclick of previous sending info to parent component
    handlePrevious(event)
    {
        console.log('this.pageCountFromParent>>>>>>>>>>>>'+this.pageCountFromParent); 
       this.dispatchEvent(new CustomEvent('previous'));
       if(this.pageCountFromParent==1)
       {
        console.log('this.pageCountFromParent>>>>>>>>>>>>'+this.pageCountFromParent);
        this.disablePrevButton=true;
       }
       else{
        //this.disablePrevButton=false;
       }

       if(this.pageCountFromParent<this.totalPageCountFromParent)
       {
        console.log('this.pageCountFromParent>>>>>>>>>>>>>'+this.pageCountFromParent);
        console.log('this.totalPageCountFromParent>>>>>>>>>>>>>>>>>>>'+this.totalPageCountFromParent);
        this.disableNextButton=false;
       }
      
    }
    handleNext(event)
    {
        this.dispatchEvent(new CustomEvent('next'));
        console.log('this.pageCountFromParent>>>>>>>>>>>>'+this.pageCountFromParent);
        console.log('this.totalPageCountFromParent>>>>>>>>>>>>>>>>>>>'+this.totalPageCountFromParent);
        console.log('handleNext>');
        if(this.pageCountFromParent>=2){
            console.log('this.pageCountFromParent in if block>>>>>>>>>>>>'+this.pageCountFromParent);
            this.disablePrevButton=false;

        }
        if(this.pageCountFromParent==this.totalPageCountFromParent)
        {
            console.log('this.pageCountFromParent>>>>>>>>>>>>>'+this.pageCountFromParent);
            console.log('this.totalPageCountFromParent>>>>>>>>>>>>>>>>>>>'+this.totalPageCountFromParent);
            this.disableNextButton=true;
        }
        else{
            this.disableNextButton=false;
        }

    }
}