
import 'dart:convert';

import 'package:restaurant/Services/api_services.dart';


import 'package:http/http.dart'as http;
import 'package:restaurant/modal/GetMenu.dart';
import 'package:restaurant/modal/getBotMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';


class getBotMenuServices extends ApiService{

  var response;
  var data;
  final String url="/items/getmenu";
  String values="";

  Future <List<BotMenu>> getBotMenus() async {

    try{



      print(values);
      var request = http.Request('POST', Uri.parse(baseUrl+url));

      request.bodyFields = {
        'AccessToken':token,
        'Parameter1':"BOT"

      };
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      //print(await request.send());
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


    return getBotMenu.fromJson(jsonDecode(response.body)).data;
  }



}