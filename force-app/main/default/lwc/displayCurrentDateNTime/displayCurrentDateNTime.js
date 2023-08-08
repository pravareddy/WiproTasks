import { LightningElement,track } from 'lwc';

export default class DisplayCurrentDateNTime extends LightningElement {
   @track time = "3:00PM";
    @track greeting="Hi...Good Afternoon";
    //console.log('hiiiiiii');
    @track toStore=[];

    connectedCallback()
    {
        this.getTime();

        setInterval(() => {
            this.getTime();
            console.log("set interval called");
        }, 1000*60);
    }

   getTime(){
       const date = new Date();
       console.log('hiiiiiii');
       console.log('date>>>'+date);
       const hour = date.getHours;
       console.log('hour>>>>'+hour);
       const min = date.getMinutes();
       console.log('min>>>>'+min);

       this.time = `${this.getHour(hour)}:${this.getDoubleDigit(min)} ${this.getMidDay(hour)}`
   }
   getHour(hour)
   {
       return hour === 0 ? 12 :hour>12 ? (hour-12) : hour;
   }
   getMidDay(hour)
   {
       return hour>=12 ? "PM":"AM";
   }
   getDoubleDigit(digit)
   {
       return digit<10 ? "0"+digit : digit;
   }
   setGreeting(hour)
   {
       if(hour<12)
       {
           this.greeting = "Good Morning";
       }
       else if(hour>=12&&hour<17)
       {
           this.greeting ="Good Afternoon";
       }
       else
       {
           this.greeting = "Good Evening";
       }
   }
   addTodoHandler()
   {
       const variable = this.template.querySelector("lightning-input");
       console.log("redddddy");
       console.log('current value ',variable.value);
       console.log('variable>>>>'+variable);
       this.toStore.push(variable.value);
       console.log('this.toStore>>>'+this.toStore);
       variable.value="";
   }
}