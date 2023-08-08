@isTest
public with sharing class Test_ContactRecForAura {
    @isTest
    public static void gettingContactTest()
    {
        Schema.Account acc = new Schema.Account();
        acc.Name = 'aura';
        acc.Phone = '12345768721';
        insert acc;
    //     //Account acc = new Account(Name = 'Test');
    //      //acc.Name='Aura';
    //    // acc.Phone='8897475466';

    //     insert acc;
    // Account acc = new Account(Name = 'Aura',Phone = '99486778900');

    // // acc.Name = 'Aura';
    // // acc.Phone = '99486778900';
    // insert acc;
        // Account acc1 = [SELECT Id,Name,Phone,Industry
        //                 FROM Account LIMIT 1];
        //                 //WHERE Id =: acc.Id];
        Contact con = new Contact(FirstName='Rithika', 
                                  LastName='Reddy',
                                  Phone='7013161420',
                                  Email='rithika88@gmail.com',
                                  Department='Finance',
                                  accountId = acc.Id);      // accountId = acc.Id
        // Contact con1 = new Contact(FirstName='Revanth', 
        //                            LastName='Reddy',
        //                            Phone='7013161420',
        //                            Email='rithika88@gmail.com',
        //                            Department='Finance',
        //                            accountId = acc.Id);
        insert con; 
        con.FirstName='sam';
        List<Contact> conList = new List<Contact>();
        conList.add(con);
        // conList.add(con1);
        
        Test.startTest();
        ContactRecForAura.gettingContact(con.accountId);
        ContactRecForAura.updatedContacts(conList);
        ContactRecForAura.deletedRecords(con.Id);
        Test.stopTest();
        
        //retrieving the record
        List<Contact> con1 = [SELECT FirstName, LastName, Phone, Email, Department 
                        FROM Contact 
                        WHERE FirstName = 'sam'];
        System.assertEquals(0, con1.size());
    }

    }