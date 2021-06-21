import 'dart:convert';

import 'package:restaurant/Services/api_services.dart';


import 'package:http/http.dart'as http;
import 'package:restaurant/modal/GetItem.dart';
import 'package:restaurant/modal/GetItemDetail.dart';

import 'package:restaurant/modal/GetSubMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetItemDetailServices extends ApiService{

  var response;
  var data;
  final String url="/items/getitemdetails";
  String detail="";
  getvalue() async {


  }
  Future <List<ItemData>> getall(int subMenuListItemId) async {

    try{




     // print(detail);
      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
        , 'Parameter1': subMenuListItemId.toString()
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


    return GetItemDetail.fromJson(jsonDecode(response.body)).data;
  }



}