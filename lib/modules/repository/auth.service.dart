import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../../../apis.dart';

class AuthService {
  Future<dynamic> registerUser(dynamic userData) async {
    try {
      dynamic response = await http.post(
          Uri.parse('$baseUrl/signup'),
          headers: {'Content-Type': 'application/json'},
          // since the type of data we are passing is json, we will give the content type as json
          body: json.encode(userData));

      // Encoding the collected data from Map to json.
      // Passing this json Data to the server which will be then passed to the database.
// The result from the database will be passed to the response variable
      dynamic responseObj = json.decode(response.body);
      print('***************************');
      print(responseObj);
// decoding the response from json to map and taking its body only, as body contains the data,statuscode etc.
      return responseObj;
    } catch (e) {
      print(e);
      print('ERRROORRR');
    }
  }

   Future<dynamic> verifyOtp(dynamic credentials) async {
    dynamic response = await http.post(
      Uri.parse('$baseUrl/verify-email'),
      headers: {'Content-Type': 'application/json'},
        body: json.encode(credentials)
    );
     dynamic responseObj = json.decode(response.body);
    return responseObj;
  }

  Future<dynamic> userLogin(dynamic credentials) async {
    try {
      dynamic response = await http.post(Uri.parse('$baseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(credentials));

      dynamic responseObj = json.decode(response.body);
      print('login responseeeeeeee isssss $responseObj');
      return responseObj;
    } catch (e) {
      print(e);
      print('ERRROORRR');
    }
  }

  Future<dynamic> resetPassword(dynamic newPasswordCredentials) async {
    try {
      print('data isssssss $newPasswordCredentials');
      dynamic response = await http.post(Uri.parse('$baseUrl/password/reset'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newPasswordCredentials));
      dynamic responseObj = json.decode(response.body);
      print('RESET RESPONSEEEEEEE $responseObj');
      return responseObj;
    } catch (e) {
      print(e);
      print('ERRROORRR');
    }
  }

  Future<dynamic> sendOtpForPasswordReset(String credentials) async {
    try {
      print('aakkkakkaka $credentials');
      dynamic response = await http.get(
        Uri.parse('$baseUrl/forgot-password/check-email?email=$credentials'),
        headers: {'Content-Type': 'application/json'},
      );
      dynamic responseObj = json.decode(response.body);

      return responseObj;
    } catch (e) {
       print('$e');
    }
  }
    sendOtpToUser(String email, String emailSubject, String emailBody) async {
   
    String emailId = 'geethuajay@gmail.com';
    String password = 'wjhptgnuhqbfqsyi';
    final smtpServer = gmail(emailId, password);
     // sending otp in email
    final message = Message()
      ..from = Address(emailId)
      ..recipients.add(email) // Recipient's email address
      ..subject = emailSubject
      ..text = emailBody;
    try {
      final sendReport = await send(message, smtpServer);
      print('email is sent');
      // print('Message sent: ${sendReport.sent}');
    } catch (error, stackTrace) {
      print('Error sending email: $error');
      print('Stack Trace: $stackTrace');
    }
  }

   Future<dynamic> resendOtp(dynamic credentials) async {
   try {
      dynamic response = await http.post(
      Uri.parse('$baseUrl/resendOtp/resend-otp'),
      headers: {'Content-Type': 'application/json'},
        body: json.encode(credentials)
    );
     dynamic responseObj = json.decode(response.body);
    return responseObj;
   } catch (e) {
      print(e);
      print('ERRROORRR');
   }
    
  }
  Future<dynamic> fetchUserDetails(String userEmailId) async{
    try {
      dynamic response = await http.get(Uri.parse('$baseUrl/user/profile?email=$userEmailId'),
       headers: {'Content-Type': 'application/json'},
       
       );
       dynamic responseObj = json.decode(response.body);

      return responseObj;
    } catch (e) {
     print('$e');  
    }
  }

  Future<dynamic> addToFavorites(dynamic data) async{
try {
  dynamic response  = await http.post
    (Uri.parse('$baseUrl/favorite/add'),
       headers: {'Content-Type': 'application/json'},
        body: json.encode(data)
  );
  dynamic responseObj = json.decode(response.body);
         print('0000000000042525,$responseObj');
  return responseObj;
} catch (e) {
   print('$e');  
}
  }
    Future<dynamic> removeFromFavorites(dynamic data) async{
try {
  dynamic response  = await http.post
    (Uri.parse('$baseUrl/favorite/remove'),
       headers: {'Content-Type': 'application/json'},
        body: json.encode(data)
  );
  dynamic responseObj = json.decode(response.body);
         print('0000000000042525,$responseObj');
  return responseObj;
} catch (e) {
   print('$e');  
}
  }
}
