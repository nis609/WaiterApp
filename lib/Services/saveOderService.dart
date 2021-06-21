import 'dart:convert';

import 'package:restaurant/ReactiveData/reactive_token.dart';
import 'package:restaurant/Services/api_services.dart';


import 'package:http/http.dart'as http;
import 'package:restaurant/modal/GetItemDetail.dart';
import 'package:restaurant/modal/GetMenu.dart';
import 'package:restaurant/modal/getKotMenu.dart';
import 'package:restaurant/modal/getSearchModal.dart';
import 'package:restaurant/modal/saveOrderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SaveOrderService extends ApiService{
  final objs = ItemData();
  var headerss = {
    'Content-Type': 'application/json'
  };

  var response;
  var data;
  final String url="/order/saveorder";
  String values="";
  getvalue() async {


  }
  Future <SaveModalOrder> saveOrderData(String tableName ,int userId,int tableId,List<ItemData> itemdata,String Username) async {

    var headerOfSaveData= {
      'Content-Type': 'application/json'
    };

    String s=jsonEncode(itemdata.map((e) => e.toJson()).toList());
    //String s=jsonEncode(itemdata);
    var request = http.Request('POST', Uri.parse(baseUrl+url));
    request.body = '''{  
      "Name":"$tableName",
       "Error":"$userId",
          "Parameter1":"$tableId",   
          "Role":"$Username",  
           "access_token":"$token",
              "Parameter2": $s}''';
    request.headers.addAll(headerOfSaveData);

    http.StreamedResponse streamedResponse = await request.send();
    response = await http.Response.fromStream(streamedResponse);
    data=jsonDecode(response.body);
    print(request.body);
    try {
      if (response.statusCode == 200) {

        print(response.reasonPhrase);
        return SaveModalOrder.fromJson(jsonDecode(response.body));
        //print(await response.stream.bytesToString());
      }
      else {

        print(response.reasonPhrase);
      }
    }catch(SocketException){
      print(SocketException);
    }

  }

  // Future <SaveModalOrder> saveOrderData(String tableName ,int userId,int tableId,List<ItemData> itemdata,String Username) async {
  //
  //   var headerOfSaveData= {
  //     'Content-Type': 'application/json'
  //   };
  //   //sir tyo tesarini garda ni licha sir
  //   //ok linchha vane vai go natra yo tarikale ni garnus hai ta
  //   //dubai tarika lae try gareko chu sir, ok as long as solve vai rako chha so problem vayana jun way le gare pani
  //   //sir mailae dropdown halna khojeko tesma ni halka problem ayerathyo tara aja ekdin afai try garchu ayae bholi sodchu hai sir
  //   //ok documentation hernus teha example pa nihuncha
  //   String s=jsonEncode(itemdata.map((e) => e.toJson()).toList());
  //   //String s=jsonEncode(itemdata);
  //   var request = http.Request('POST', Uri.parse(baseUrl+url));
  //   request.body =''' {
  //     "Name": "$tableName",
  //     "Error": "$userId",
  //     "Parameter1": "$tableId",
  //     "Role":"$Username"
  //     "Parameter2": $s,
  //     "access_token":"$token",
  //   }''';
  //   request.headers.addAll(headerOfSaveData);
  //
  //   http.StreamedResponse streamedResponse = await request.send();
  //   response = await http.Response.fromStream(streamedResponse);
  //   data=jsonDecode(response.body);
  //   print(request.body);
  //   try {
  //     if (response.statusCode == 200) {
  //       print(data);
  //       print(response.reasonPhrase);
  //       return SaveModalOrder.fromJson(jsonDecode(response.body));
  //       //print(await response.stream.bytesToString());
  //     }
  //     else {
  //       print(data);
  //       print(response.reasonPhrase);
  //     }
  //   }catch(SocketException){
  //     print(SocketException);
  //   }
  //
  // }

}


//sir mero chahi 2 ota problem ma cha
//sir tesma jlekhni
//problem sir