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

import 'package:restaurant/modal/GetSubMenu.dart';
import 'package:restaurant/modal/getComment.dart';
import 'package:shared_preferences/shared_preferences.dart';


class getCommentServices extends ApiService{

  var response;
  var data;
  final String url="/items/getcomments";
  String detail="";
  getvalue() async {


  }
  Future <List<Comments>> getComentDetail(int parentIndex) async {

    try{

      final pres = await SharedPreferences.getInstance();
      final keys = 'ItemId';
      detail = pres.get(keys) ;
      pres.clear();



      // print(detail);
      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
        , 'Parameter1': parentIndex.toString()
      };

      print("parentIndex"+parentIndex.toString());
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(GetItemDetail().data);






      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());

    }


    return GetComment.fromJson(jsonDecode(response.body)).data;
  }
  Future <GetComment> getComentDetails(int parentIndex) async {
    parentIndex=16;
    try{





      // print(detail);
      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
        , 'Parameter1': parentIndex.toString()
      };


      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(GetItemDetail().data);



      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());

    }


    return GetComment.fromJson(jsonDecode(response.body));
  }



}