@RestResource(urlMapping='/createContact/*')
global class PutMethodForContact {
    @HTTPPut
    global static Id aboutContact(String contactFName, String contactLName, String contactPhone, String contactEmail)
    {
        Contact con = new Contact(
            	FirstName = contactFName,
                LastName = contactLName,
                Phone = contactPhone,
                Email = contactEmail
        );
        upsert con;
        return con.Id;
    }
    

}