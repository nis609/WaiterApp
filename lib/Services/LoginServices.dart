import 'dart:convert';
import 'dart:io';


import 'package:restaurant/Services/api_services.dart';
import 'package:restaurant/modal/LoginModal.dart';
import 'package:http/http.dart'as http;




class LoginService extends ApiService{

  var response;
  var data;
  final String url="/login/login";

  Future <LoginModal> creates(String userName,String password) async {
ApiService api= new ApiService();
print(api.token);
try{

  var request = http.Request('POST', Uri.parse(baseUrl+url));
  request.bodyFields = {
    'username': userName,
    'password': password
  };
  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  response = await http.Response.fromStream(streamedResponse);
  data=jsonDecode(response.body);
  if (response.statusCode == 200) {

  }
  else {
    print(response.reasonPhrase);

  }

    } catch (e) {
  print(e.toString());

  }


  return LoginModal.fromJson(jsonDecode(response.body));
  }

  Future <List<CreateUser>> CreateUsers(String userName,String password) async {
    ApiService api= new ApiService();
    print(api.token);
    try{

      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'username': "c",
        'password': "1"
      };
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {
        return LoginModal.fromJson(jsonDecode(response.body)).data;

        print("23");
        // khai kei return garnua vako chahian yeaha ga
        //sir username chahi print vayo
        //sir problem chahi sir malai username ko data pass garnu cha??

        //print('${data['Token']}');
      }
      else {
        print(response.reasonPhrase);

      }

    } catch (e) {
      print(e.toString());
      return null;

    }


  }
  // Future <List<Data>> create() async {
  //
  //   try{
  //     var headers = {
  //       'Content-Type': 'application/x-www-form-urlencoded'
  //     };
  //     var request = http.Request('POST', Uri.parse('https://19a29bf0d140.ngrok.io/api/login/login'));
  //     request.bodyFields = {
  //       'username': 'admin',
  //       'password': 'admin'
  //     };
  //     request.headers.addAll(headers);
  //
  //     http.StreamedResponse streamedResponse = await request.send();
  //     response = await http.Response.fromStream(streamedResponse);
  //     data=jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       print("23");
  //
  //       print('${data['Token']}');
  //     }
  //     else {
  //       print(response.reasonPhrase);
  //     }
  //
  //   } catch (e) {
  //     print(e.toString());
  //
  //   }
  //
  //
  //   return LoginModal.fromJson(jsonDecode(response.body)).data;
  // }
}