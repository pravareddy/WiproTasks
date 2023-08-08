@isTest
global class NotificationsInAccountTabMock_T implements HttpCalloutMock {
     //implement interface method 
    global HttpResponse respond(HttpRequest request){
        //Creating a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"notificationDetails":{"notifications":[{"type":"Email","subject":"A new contact has been changed","Message":"Hi your contact number got changed .will you please check and inform us","ToAddress":"pravalikareddy3663@gmail.com","CreatedTime":"2023-07-05T07:15:00.821z"},{"type":"SMS","subject":"-","Message":"Hi your request to add contact to account is succeed","ToAddress":"pravalikareddy3663@gmail.com","CreatedTime":"2023-07-05T07:15:00.821z"}]}}');
        response.setStatusCode(200);
        return response;
    }

}