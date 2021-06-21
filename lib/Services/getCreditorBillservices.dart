
import 'dart:convert';

import 'package:restaurant/Services/api_services.dart';
import 'package:restaurant/modal/GetTotalBills.dart';
import 'package:restaurant/modal/billPaymentMode.dart';
import 'package:http/http.dart'as http;
import 'package:restaurant/modal/getCreditorBill.dart';
import 'package:restaurant/ui/Bot.dart';
class GetCreditorsBillsService extends ApiService{
  var response;
  var data;
  final String url="/bill/getcreditors";
  String values="";
  Future <List<CreditorBill>> getCredtorsBills() async {

    try{



      print(values);
      var request = http.Request('POST', Uri.parse(baseUrl+url));

      request.bodyFields = {
        'AccessToken':token,
        'Parameter1':""

      };
      request.headers.addAll(headers);
      print(request.bodyFields);
      http.StreamedResponse streamedResponse = await request.send();
      //print(await request.send());
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);

      try{
        if (response.statusCode == 200) {


          return GetCreditorBill.fromJson(jsonDecode(response.body)).data;
        }
        else {
          print(response.reasonPhrase);
        }

      } catch (e) {
        print(e.toString());

      }}
    catch(SocketException ){
      print(SocketException);
    }



  }
  Future <List<CreditorBill>> getCredtorsBillss(String names) async {

    try{




      var request = http.Request('POST', Uri.parse(baseUrl+url));

      request.bodyFields = {
        'AccessToken':token,
        'Parameter1':names

      };
      request.headers.addAll(headers);
      print(request.bodyFields);
      http.StreamedResponse streamedResponse = await request.send();
      //print(await request.send());
      response = await http.Response.fromStream(streamedResponse);
      data=jsonDecode(response.body);
      print(response.statusCode);
      try{
      if (response.statusCode == 200) {
        print(data);

        return GetCreditorBill.fromJson(jsonDecode(response.body)).data;
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());

    }}
    catch(SocketException ){
      print(SocketException);
    }



  }


}