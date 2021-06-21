import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:restaurant/Services/api_services.dart';
import 'package:restaurant/modal/GetItemDetail.dart';
import 'package:restaurant/modal/saveOrderModel.dart';
import 'package:http/http.dart'as http;
class checkService extends ApiService{

  var headerss = {
    'Content-Type': 'application/json'
  };

  var response;
  var data;
  final String url="/order/saveordertest";
  Future <SaveModalOrder> saveOrderDatas(String tableName ,int userId,int tableId,List<ItemData> itemdata) async {

    var headerOfSaveData= {
      'Content-Type': 'application/json'
    };
    String s=jsonEncode(itemdata);
    var request = http.Request('POST', Uri.parse(baseUrl+url));
    request.body =''' {
      "Name": "$tableName",
      "Error": "$userId",
      "Parameter1": "$tableId",
      "Parameter2": $s,
      "access_token":"$token",
    }''';
    request.headers.addAll(headerOfSaveData);

    http.StreamedResponse streamedResponse = await request.send();
    response = await http.Response.fromStream(streamedResponse);
    data=jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return SaveModalOrder.fromJson(jsonDecode(response.body));
      //print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }


  }
//this one


}