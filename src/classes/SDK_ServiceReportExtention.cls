public with sharing class SDK_ServiceReportExtention {

    private final CKSW_BASE__Service__c service;
    public String staticMapPath {get;set;}
    public SDK_ServiceReportExtention(ApexPages.StandardController stdController) {
        service = (CKSW_BASE__Service__c)stdController.getRecord();
        try
        {
        String lat = service.CKSW_BASE__Geolocation__latitude__s.format();
        String lng = service.CKSW_BASE__Geolocation__longitude__s.format();
        staticMapPath = 'https://maps.googleapis.com/maps/api/staticmap?size=512x512&maptype=roadmap&markers=size:mid%7Ccolor:red%7C'+ lat +','+lng;
        }
        catch(Exception e) 
        {
           staticMapPath = null; 
        }

    }

    public Account  getAccount() {
        try
        {
            return [select Name,Phone,Fax,Industry,Type,BillingAddress from Account where Id =:service.CKSW_BASE__Account__c limit 1];
        }
        catch(Exception ex)
        {
            return null;
        }
       
    }
    public List<CKSW_BASE__Service_Skill__c> getSkills()
    {
        return [select CKSW_BASE__Skill__r.Name from CKSW_BASE__Service_Skill__c where CKSW_BASE__Service__c =:service.Id limit 100];
    }
    
    public List<CKSW_BASE__Service_Product__c> getProductsUsed()
    {
        return [select Id, CKSW_BASE__Product__r.Name, CKSW_BASE__Quantity_Used__c from CKSW_BASE__Service_Product__c where CKSW_BASE__Service__c =: service.Id and CKSW_BASE__Quantity_Used__c !=null limit 1000];
    }

    public List<Opportunity> getOpps()
    {
        return [Select id, Name, Account.Name, CloseDate, Amount, Type from Opportunity where Account.id = :service.CKSW_BASE__Account__c limit 10];
    }
}