/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @author         Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @modifiedBy     Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @maintainedBy   Pravalika Reddy         <PravalikaReddy.Rangaiahgari@raaagvitech.com>
* @version        56.0
* @created        2023-04-19
* @modified      
* @ClassName    MortgageKafkaStructure   
*  **/
public with sharing class MortgageKafkaStructure {
   
    public  class Application1
    {
        public wrapnumberLong Id{get; set;}    
        public wrapDate creationDateUTC{get; set;}
        public wrapdmlDate dmlDateUTC{get; set;}
        public Boolean isActive{get; set;}
        public String applicationType{get; set;}
        public String status{get; set;}
        public List<wrapApplicant> Applicants{get; set;}
        public List<wrapQuestionnaires> Questionnaires{get; set;}
        public List<wrapCurrentAddress> CurrentAddress{get; set;}
        
        
    }
    
    public class wrapnumberLong
    {
        public String numberLong{get; set;}
    }
    public class wrapDate
    {
        public Date creatDate{get; set;}
    }
    public class wrapdmlDate
    {
        public Date dmlDate{get; set;}
    }
    
    
    
    public class wrapApplicant
    {
        public String Id{get; set;}
        public String Type{get; set;}
        public wrapName Name{get; set;}
        public String Phone{get; set;}
        public String Email{get; set;}
        public wrapDateDob Dob{get; set;}
        public String MaritalStatus{get; set;}
        public String LanguagePreference{get; set;}
        
    }
    public class wrapName
    {
        public String firstName{get; set;}
        public String lastName{get; set;}
    }
    public class wrapDateDob
    {
        public Date dobDate{get; set;}
    }
    public class wrapQuestionnaires
    {
        public String Id{get; set;}
        public String Url{get; set;}
        public String Type{get; set;}
        public String Status{get; set;}
    }
    
    public class wrapCurrentAddress
    {
        public String StreetNumber{get; set;}
        public String StreetName{get; set;}
        public String StreetType{get; set;}
        public String City{get; set;}
        public String Province{get; set;}
        public String PostalCode{get; set;}
        public String Country{get; set;}
        
    }
}