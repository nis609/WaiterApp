
import 'dart:convert';

import 'package:restaurant/Services/api_services.dart';
import 'package:restaurant/modal/GetTotalBills.dart';
import 'package:restaurant/modal/billPaymentMode.dart';
import 'package:http/http.dart'as http;
import 'package:restaurant/ui/Bot.dart';
class GetTotalBillsService extends ApiService{
  var response;
  var data;
  final String url="/bill/getall";
  String values="";

  Future <List<TotalBills>> getTotalBills(int tableId) async {

    try{



      print(values);
      var request = http.Request('POST', Uri.parse(baseUrl+url));

      request.bodyFields = {
        'AccessToken':token,
        'Parameter1':tableId.toString()

      };
      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      //print(await request.send());
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      if (response.statusCode == 200) {


      }
      else {
        print(data);
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());

    }


    return GetTotalBills.fromJson(jsonDecode(response.body)).totalBills;
  }


}