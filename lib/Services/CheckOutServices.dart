
import 'dart:convert';

import 'package:flutter/scheduler.dart';
import 'package:restaurant/Services/api_services.dart';
import 'package:restaurant/modal/CheckOut.dart';
import 'package:restaurant/modal/billPaymentMode.dart';
import 'package:http/http.dart'as http;
import 'package:restaurant/modal/getCreditorBill.dart';
class CheckOutService extends ApiService{
  var response;
  var data;
  final String url="/bill/savebill";
  String values="";

  Future <CheckOut> getCheckout(int tableId,int userId,List<CreditorBill> creditorBill,String modeOfPayement) async {

    try{



      print(values);
      var request = http.Request('POST', Uri.parse(baseUrl+url));

      request.bodyFields = {
        'AccessToken':token,
        'Parameter1':tableId.toString(),
        "Role":userId.toString(),
        "Name":modeOfPayement,
        'Parameter2':{"Id":creditorBill.first.Id,"Phone":creditorBill.first.phone}.toString()

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


    return CheckOut.fromJson(jsonDecode(response.body));
  }


}