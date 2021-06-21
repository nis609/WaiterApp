import 'dart:convert';

import 'package:restaurant/Services/api_services.dart';
import 'package:restaurant/modal/getTablePreviousOrderForNewKOTModal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class getTablePreviousOrderForNewKOTService extends ApiService{

  var response;
  var data;
  final String url="/tables/getprevorderinfo";
  String detail="";
  getvalue() async {


  }
  Future <List<PreviousList>> getPrviousList(int tableId) async {

    try{



      var request = http.Request('POST', Uri.parse(baseUrl+url));
      request.bodyFields = {
        'AccessToken':token
        , 'Parameter1':"$tableId"
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


    return getTablePreviousOrderForNewKOT.fromJson(jsonDecode(response.body)).data;
  }

}