public with sharing class CSVUploadContactsApex1 {
    
// @AuraEnabled(cacheable=true)
    // public static List<Contact> getAccountDataToExport(Id recId){
    //     List<Contact> lstContacts = [SELECT Id, FirstName, LastName, Email 
    //                                  FROM Contact
    //                                  WHERE accountId =: recId];
    //     return lstContacts;
    // }
    // @AuraEnabled(cacheable=true)
    // public static List<Contact> getAccountDataToExport(){
    //     List<Contact> conList = [SELECT Id, FirstName, LastName, Email 
    //                                  FROM Contact
    //                                  ];
    //     return conList;
    // }
    @AuraEnabled(cacheable=true)
    public static Wrapper wrapGettingMetadata(String recId)
    {
        List<String> strList = new List<String>();
        Map<String,String> mapOfStrings = new Map<String,String>();
        mapOfStrings.put('id', 'id');
        //List<Contact> conList = new List<Contact>();
        Application__mdt application = [SELECT Content_Object_API_Name__c, Content_Object_Label__c
                                             FROM Application__mdt
                                             WHERE Label =: 'Contact files Application'];
        System.debug('this is metdataa');
        System.debug('application>>>>>>>>'+application);
        
        CSV_File_Upload_Object__mdt csvFileObject =[SELECT Application__c, Data_Object_API_Name__c, Data_Object_Label__c, Parent_Field_API_Name__c
                                                          FROM CSV_File_Upload_Object__mdt
                                                          WHERE Application__r.id =: application.id];
        System.debug('csvFileObject>>>>>>>>>>'+csvFileObject);
       
        List<CSV_File_Upload_Field__mdt>  csvFileField = [SELECT CSV_Coloumn_Name__c, Field_API_Name__c, field_Label__c, Required__c, Sequence__c, CSV_File_Upload_Object__r.Data_Object_API_Name__c, CSV_File_Upload_Object__r.Data_Object_Label__c, CSV_File_Upload_Object__r.Parent_Field_API_Name__c
                                              FROM CSV_File_Upload_Field__mdt
                                              WHERE CSV_File_Upload_Object__r.id =: csvFileObject.id
                                              ];
        System.debug('csvFileField>>>>>>>>>'+csvFileField);
        
    
      for(CSV_File_Upload_Field__mdt csvFile:csvFileField)
      {
        strList.add(csvFile.CSV_Coloumn_Name__c);
        mapOfStrings.put(csvFile.CSV_Coloumn_Name__c,csvFile.Field_API_Name__c);

      }


      System.debug('strList>>>>>'+strList);
     strList[0].trim();
      System.debug('strList>>>>>'+strList);
      //strList[0].remove(')');
      //List<Contact> contactList = new List<Contact>();
    //   String commaSepratedList='';

    //   for(String str : strList)

    //    {

    //      commaSepratedList += str + ',' ;

    //     }  
        //System.debug('commaSepratedList>>>>>>>>>>>>>'+commaSepratedList);
        //List<String> strList = new List<String>();
      String query = 'SELECT ' +String.join(strList,',')+ ' FROM Contact WHERE accountId =: recId';
      System.debug('query>>>>>'+query);
      //String query = 'SELECT ' +commaSepratedList+ ' FROM Contact WHERE accountId =: recId';
        
        // for(Contact con:query)
        // {
        //     contactList.add(con);
        // }
        // System.debug(' contactList>>>>>>'+ contactList);
        //map<Id,List<Contact>> idContactMap = new map<Id,List<Contact>>();


        //prepare a csv file using string
        String columnDivider =',';
        String lineDivider ='\n';
        String storeLabels = '';
        String storeValues = '';
        
        for(String stringName : strList)
        {
          storeLabels += mapOfStrings.get(stringName) + columnDivider;
        }
        storeLabels += lineDivider;
        System.debug('storeLabels>>>>>>>>>>'+storeLabels);
        //System.debug('conList>>>>>>>>>>>'+conList);
        List<Contact> conList = Database.Query(query);
        for(Contact conn : conList)
        {
           for(String stringName :strList)
           {
            storeValues += conn.get(stringName) + columnDivider;
           }
           //storeValues += lineDivider;
        }
        System.debug('storeValues>>>>>>>>.'+storeValues);
        //Map<Id,  Contact> mapOfcontactList = new Map<Id, Contact>(conList);

         //List<String> strList2 = new List<String>();
        //System.debug('entering into map');
        //System.debug('mapOfcontactList>>>>>>>>'+mapOfcontactList.values());
        //mapOfcontactList.put(1, conList);
        //List<Contact> conList1 = mapOfcontactList.remove('Contact');
        // for(Contact con:conList)
        // {
        //    String str1 = mapOfcontactList.get(con.Id).Phone;
        //    String str2 = mapOfcontactList.get(con.Id).FirstName;
        //    String str3 = mapOfcontactList.get(con.Id).Email;
        //    String str4 = mapOfcontactList.get(con.Id).LastName;
        //   System.debug('str1>>>>'+str1);
        //   strList2.add(str1);
        //   strList2.add(str2);
        //   strList2.add(str3);
        //   strList2.add(str4);
          
          
            //Contact contact = new Contact();
            // con.Phone= mapOfcontactList.get(con.Id).Phone;
            // con.FirstName= mapOfcontactList.get(con.Id).FirstName;
            // con.Email= mapOfcontactList.get(con.Id).Email;
            // con.LastName= mapOfcontactList.get(con.Id).LastName;
            // System.debug('con.Phone>>>>'+con.Phone);
            // System.debug('con.Email>>>>'+con.Email);
            // conList2.add(con);
            
            // mapOfcontactList.get(con.Id).FirstName = str2[1];
            //  mapOfcontactList.get(con.Id).Email = str2[2];
        //}
        
        //System.debug('strList2>>>>>'+strList2);

            //  mapOfcontactList.get(con.Id).LastName = str2[3];
        //     //contact.Email =mapOfcontactList.get(con.Id).Email;
        //     //contact.FirstName =mapOfcontactList.get(con.Id).FirstName;
        //     //contact.LastName =mapOfcontactList.get(con.Id).LastName;
        //      System.debug('str1>>>>>>>>>>>>>>'+str1);
        // }
        
        //System.debug('mapOfcontactList2>>>>>>>>'+mapOfcontactList);
        //System.debug('str>>>>>>>>'+str);
        //List<Contact> conList1 = mapOfcontactList.values();
         //System.debug('str2>>>>>>>>>'+str2);
        // for(contactValues conValues :conList)
        // {s
        //     mapOfcontactList =  
        // }
        //List<Contact> newConList = new List<Contact>();
        //newConList = mapOfcontactList.values();
       // System.debug('newConList>>>>>>>>>>>'+newConList);
        Wrapper wrap = new Wrapper();
        //wrap.app=application;
        //wrap.csvFileObj=csvFileObject;
        wrap.csvFileFieldList=storeLabels;
        wrap.con1=storeValues;
        System.debug('wrap>>>>>>>'+wrap);
        
        return wrap;
    }





        public class Wrapper
        {
        //   @AuraEnabled
        //   public Application__mdt app;
        //   @AuraEnabled
        //   public CSV_File_Upload_Object__mdt csvFileObj;
          @AuraEnabled
          public String csvFileFieldList;
          @AuraEnabled
          public String con1;
             
          }
        }
    
    // public static Wrapper getContactsByWrap()
    // {
        
    //     List<String> strList = [SELECT  Field_API_Name__c
    //                         FROM CSV_File_Upload_Field__mdt];
                            
    //    Wrapper wrap = new Wrapper();

    //    wrap.strList=strList;
    //    system.debug('wrap>>>>>>>>>'+wrap);
    //    return wrap;
    // }
    // public class wrapper
    // {
    //     @AuraEnabled
    //     public List<String> strList;
        
        
    // }