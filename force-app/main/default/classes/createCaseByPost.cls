@RestResource(urlMapping='/SampleCase/*')
global class createCaseByPost {
    @HTTPGet
    Global static Contact getContact()
    {
        RestRequest req = RestContext.request;
        System.debug('req>>>>>>>>>>>>>>>>>>>>>>'+req);
        String conId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        System.debug('conId>>>>>>>>>>>>>'+conId);
        
        Contact con = [SELECT Name,Phone
                       FROM Contact
                       WHERE accountId =: conId];
        System.debug('con>>>>>>>>>>'+con);
        return con;
    }
    @HTTPPost
    Global static Id caseInsert(String caseStatus, String caseOrigin, String caseSubject)
    {
        Case cass = new Case(
            Status = caseStatus,
            Origin = caseOrigin,
            Subject = caseSubject
        );
        insert cass;
        return cass.Id;
    }
}