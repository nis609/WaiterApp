
import 'dart:convert';

import 'package:restaurant/Services/api_services.dart';
import 'package:restaurant/modal/billPaymentMode.dart';
import 'package:http/http.dart'as http;
class PayemantModeService extends ApiService{
  var response;
  var data;
  final String url="/bill/getpaymode";
  String values="";

  Future <List<ModeOfPayment>> getPaymentMode(int index) async {
    if (index != null) {
      try {
        print(values);
        var request = http.Request('POST', Uri.parse(baseUrl + url));

        request.bodyFields = {
          'AccessToken': token,
          'Parameter1': "1"
        };
        request.headers.addAll(headers);

        http.StreamedResponse streamedResponse = await request.send();
        //print(await request.send());
        response = await http.Response.fromStream(streamedResponse);
        data = jsonDecode(response.body);
        if (response.statusCode == 200) {

        }
        else {
          print(response.reasonPhrase);
        }
      } catch (e) {
        print(e.toString());
      }


      return PayemantMode
          .fromJson(jsonDecode(response.body))
          .data;
    }
  }


}