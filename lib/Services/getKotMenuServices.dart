import 'dart:convert';

import 'package:restaurant/Services/api_services.dart';


import 'package:http/http.dart'as http;
import 'package:restaurant/modal/GetMenu.dart';
import 'package:restaurant/modal/getKotMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';


class getKotMenuServices extends ApiService{

  var response;
  var data;
  final String url="/items/getmenu";
  String values="";
  getvalue() async {


  }
  Future <List<KotMenu>> getKotMenus() async {

    try{

      var request = http.Request('POST', Uri.parse(baseUrl+url));

      request.bodyFields = {
        'AccessToken':token,
        'Parameter1':"KOT"

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


    return getKotMenu.fromJson(jsonDecode(response.body)).data;
  }



}