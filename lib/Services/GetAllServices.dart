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
import 'package:shared_preferences/shared_preferences.dart';


class GetAllServices extends ApiService{

  var response;
  var data;
  final String url="/tables/getall";
  String values="";
  getvalue() async {


  }
  Future <List<GetAllTableData>> getall() async {

    try{




      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
      };
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {

      }
      else {

      }

    } catch (e) {
      print(e.toString());

    }


   return GetAllTableModal.fromJson(jsonDecode(response.body)).data;
  }



}