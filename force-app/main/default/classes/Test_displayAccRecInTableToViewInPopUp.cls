@isTest
public with sharing class Test_displayAccRecInTableToViewInPopUp {
    @isTest
     static void insertListOfAccount(){
        List<Schema.Account> accList = new List<Schema.Account>();
        Schema.Account acc1 = new Schema.Account();
        acc1.Name='PopUp';
        acc1.Phone='7386098876';
        acc1.Rating='Cold';
        acc1.Industry='Construction';
        acc1.Active__c='Yes';

        Schema.Account acc2 = new Schema.Account();
        acc2.Name='PopUp1';
        acc2.Phone='7386098876';
        acc2.Rating='Cold';
        acc2.Industry='Construction';
        acc2.Active__c='Yes';
        accList.add(acc1);
        accList.add(acc2);
        insert accList;


        //inserting another account for another method
        Schema.Account sampAcc = new Schema.Account();
        sampAcc.Name='SamplePopUp';
        sampAcc.Phone='9948058031';
        sampAcc.Rating='Cold';
        sampAcc.Industry='Electronics';
        sampAcc.Active__c='Yes';
        insert sampAcc;

        Test.startTest();
        displayAccRecInTableToViewInPopUp.getAccounts();
        displayAccRecInTableToViewInPopUp.getSingleAccount(sampAcc.Id);
        Test.stopTest();
        System.assertEquals('SamplePopUp', sampAcc.Name);

    }
}