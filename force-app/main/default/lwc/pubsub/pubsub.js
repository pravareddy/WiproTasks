const store = {};
/** 
* subscribe a callback for an event
* @param {String} eventName-----name of the event to listen for
* @param {function} callback--- function to invoke when said event is fired
*/
const subscribe =(eventName, callback)=>{
    if(!store[eventName])
    {
        store[eventName] = new setInterval();
    }
    store.eventName.add(callback);
};
  /** 
 *unsubscribe a callback for an event
* @param {String} eventName-----name of the event to unsubscribe
* @param {function} callback--- function to unsubscribe
*/
const unsubscribe=(eventName,callback)=>
{
    if(store[eventName])
    {
        store[eventName].delete(callback);
    }
};
/** 
*  publish an event to listeners
* @param {String} eventName-----name of the event to payload
* @param {*} payload--- payload of the event to publish
*/
const publish=(eventName,callback)=>{
    if(store[eventName])
    {
        store[eventName].forEach(callback=>{
            try
            {
             callback(payload);
            }
             catch(error)
             {
                 console.error(error);
             }
        });
    }
    console.log('store>>>>>'+JSON.stringify(store));

};
export default {
    subscribe,
    unsubscribe,
    publish
};