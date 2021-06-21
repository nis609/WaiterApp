import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:restaurant/ReactiveData/reactive_token.dart';
import 'package:restaurant/Services/api_services.dart';


import 'package:http/http.dart'as http;
import 'package:restaurant/modal/GetItem.dart';

import 'package:restaurant/modal/GetSubMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetMenuItemServices extends ApiService{

  var response;
  var data;
  final String url="/items/getitems";
  String value="";
  getvalue() async {


  }
  Future <List<MenuItem>> getall( int subMenuId) async {

    try{


      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
        , 'Parameter1': subMenuId.toString()
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


    return GetItem.fromJson(jsonDecode(response.body)).data;
  }
  Future <List<MenuItem>> getalls( int subMenuId,int index) async {
if(index!=null) {
  try {
    var request = http.Request('POST', Uri.parse(baseUrl + url));
    request.bodyFields = {
      'AccessToken': token
      , 'Parameter1': subMenuId.toString()
    };


    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    response = await http.Response.fromStream(streamedResponse);
    data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
    }
    else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e.toString());
  }
}


    return GetItem.fromJson(jsonDecode(response.body)).data;
  }




}