public with sharing class Accountaurocontroller {
    
    @AuraEnabled
     public  static Account fetchacc(String idd){

       Account  acc = new Account();
        try{
         acc = [select id,name,accountrevenue__c,NumberOfEmployees from account where id =:idd];
        }catch(Exception e){
          system.debug(e.getMessage());
        }
        return acc;
        
    }
   
    @AuraEnabled
     public  static String createacc(String Name,Integer Accountrevenue,Integer numemp){

       Account  acc = new Account();
        try{
            acc.name	 = Name;
            acc.AccountRevenue__c = Accountrevenue;
            acc.NumberOfEmployees = numemp;
            insert acc;
        }catch(Exception e){
            return e.getMessage();
        }
        return acc.id;
        
    }
    
    
    @AuraEnabled
     public  static String updateacc(String Name,Integer Accountrevenue,String idd,Integer numemp){

       Account  acc = new Account();
        try{
             acc = [select id,name,accountrevenue__c,NumberOfEmployees from account where id =:idd];
            acc.name	 = Name;
            acc.AccountRevenue__c = Accountrevenue;
            acc.NumberOfEmployees = numemp;
            
            if(Schema.SObjectType.Account.Fields.NumberOfEmployees.isUpdateable() == true){
                update acc;
            }else {
                return 'this user cannot update this field because of FLS REQUIRED_FIELD_MISSING';
                
            }
        }catch(Exception e){
            return e.getMessage();
        }
        return acc.id;
        
    }


}
