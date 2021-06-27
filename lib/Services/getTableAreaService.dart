
import 'dart:convert';

import 'package:restaurant/Services/api_services.dart';


import 'package:http/http.dart'as http;
import 'package:restaurant/modal/GetMenu.dart';
import 'package:restaurant/modal/getArea.dart';
import 'package:restaurant/modal/getBotMenu.dart';
import 'package:restaurant/modal/getTableByArea.dart';
import 'package:shared_preferences/shared_preferences.dart';


class getTableAreaServices extends ApiService{

  var response;
  var data;
  final String url="/tables/gettablebyarea";
  String values="";

  Future <List<TablesByArea>> getAreaOfTable(int TableId) async {

    try{



      print(values);
      var request = http.Request('POST', Uri.parse(baseUrl+url));

      request.bodyFields = {
        'AccessToken':token,
        'Parameter1':TableId.toString()

      };
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      //print(await request.send());
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {
print(data);
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());

    }


    return getTablesByArea.fromJson(jsonDecode(response.body)).tablesByArea;
  }



}