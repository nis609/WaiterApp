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
import 'package:restaurant/modal/GetItemDetail.dart';
import 'package:restaurant/modal/GetItemModifier.dart';

import 'package:restaurant/modal/GetSubMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetItemModifierServices extends ApiService{

  var response;
  var data;
  final String url="/items/getmodifier";
  String detail="";
  getvalue() async {


  }
  Future <List<ItemModifier>> getItemModifier( int subMenuIdForModifier) async {

    try{

      final pres = await SharedPreferences.getInstance();
      final keys = 'ItemId';
      detail = pres.get(keys) ;


      print(detail);
      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
        , 'Parameter1': subMenuIdForModifier.toString()
      };
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {
        //print("23");

        // print('${data['Token']}');
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());

    }


    return GetItemModifier.fromJson(jsonDecode(response.body)).data;
  }


  Future <GetItemModifier> getItemModifiers( int subMenuIdForModifier) async {

    try{


      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
        , 'Parameter1': subMenuIdForModifier.toString()
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


    return GetItemModifier.fromJson(jsonDecode(response.body));
  }
}