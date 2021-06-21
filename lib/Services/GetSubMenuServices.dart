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

import 'package:restaurant/modal/GetSubMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetSubMenuServices extends ApiService{

  var response;
  var data;
  final String url="/items/getsubmenu";
  String values="";
  getvalue() async {


  }
  Future <List<SubMenuDetail>> getall( int menuId) async {

    try{


      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
   , 'Parameter1': menuId.toString()
      };
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {

        // print('${data['Token']}');
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());

    }


    return GetSubMenu.fromJson(jsonDecode(response.body)).data;
  }

  Future <List<SubMenuDetail>> getalls( int menuId,int index) async {
if(index!=null) {
  try {
    var request = http.Request('POST', Uri.parse(baseUrl + url));
    request.bodyFields = {
      'AccessToken': token
      , 'Parameter1': menuId.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    response = await http.Response.fromStream(streamedResponse);
    data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      // print('${data['Token']}');
    }
    else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e.toString());
  }
}
    return GetSubMenu.fromJson(jsonDecode(response.body)).data;
  }




}