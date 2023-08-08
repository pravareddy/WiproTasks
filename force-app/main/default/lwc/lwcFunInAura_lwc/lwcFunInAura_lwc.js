import { LightningElement} from 'lwc';

export default class LwcFunInAura_lwc extends LightningElement {
    DisplayText = false;
    textValue='LWC Function Invoked through Aura Component'  
      LWCFunction()
    {
      this.DisplayText = true; 
    }
  }