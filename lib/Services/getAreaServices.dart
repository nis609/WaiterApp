import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:restaurant/ReactiveData/reactive_token.dart';
import 'package:restaurant/Services/api_services.dart';
import 'package:restaurant/modal/GetAllModal.dart';

import 'package:http/http.dart'as http;
import 'package:restaurant/modal/GetOpenTable.dart';
import 'package:restaurant/modal/getArea.dart';
import 'package:shared_preferences/shared_preferences.dart';


class getAreaServices extends ApiService{
  @override
  // TODO: implement token
  var response;
  var data;
  final String url="/tables/getarea";
  String values="";
  getvalue() async {


  }



  Future <List<AreaTable>> getAreas() async {

    try{



      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
        // 'AccessToken':token
      };
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {
print(getArea.fromJson(jsonDecode(response.body)).token);
return getArea.fromJson(jsonDecode(response.body)).data;
      }
      else {

        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());

    }



  }




}