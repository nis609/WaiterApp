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
import 'package:restaurant/modal/GetMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetMenuServices extends ApiService{

  var response;
  var data;
  final String url="/items/getmenu";
  String values="";
  getvalue() async {


  }
  Future <List<Data>> getall(String menu) async {

    try{
      final pres = await SharedPreferences.getInstance();
      final keys = 'token';
      values = pres.get(keys) ;


      print(values);
      var request = http.Request('POST', Uri.parse(baseUrl+url));
      print(menu+"menu");
      request.bodyFields = {
        'AccessToken':token,
        'Parameter1':menu

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


    return GetMenu.fromJson(jsonDecode(response.body)).data;
  }



}