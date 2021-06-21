import 'dart:convert';

import 'package:restaurant/ReactiveData/reactive_token.dart';
import 'package:restaurant/Services/api_services.dart';


import 'package:http/http.dart'as http;
import 'package:restaurant/modal/GetCloseTable.dart';



class GetCloseTableService extends ApiService{

  var response;
  var data;
  final String url="/tables/getclose";
  String values="";
  getvalue() async {


  }
  Future <List<CloseTable>> getall() async {

    try{


      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
      };
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {
        //print("23");
        //print(data);
        // print('${data['Token']}');
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());

    }


    return GetCloseTable.fromJson(jsonDecode(response.body)).data;
  }



}