import 'dart:convert';

import 'package:restaurant/Services/api_services.dart';


import 'package:http/http.dart'as http;
import 'package:restaurant/modal/GetMenu.dart';
import 'package:restaurant/modal/getKotMenu.dart';
import 'package:restaurant/modal/getSearchModal.dart';
import 'package:shared_preferences/shared_preferences.dart';


class searchItemServices extends ApiService{
 List<SearchItem> categories;
  var response;
  var data;
  final String url="/items/searchitems";
  String values="";
  getvalue() async {


  }
  Future <List<SearchItem>> searchItem(String searchparameter) async {

    try{
      final pres = await SharedPreferences.getInstance();
      final keys = 'token';
      values = pres.get(keys) ;


      print(values);
      var request = http.Request('POST', Uri.parse(baseUrl+url));

      request.bodyFields = {
        'AccessToken':token,
        'Parameter1':searchparameter

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


    return getSearchModal.fromJson(jsonDecode(response.body)).data;
  }
static SearchItem parseItems( String responsebody){
    final parsed =json.decode(responsebody).cast<Map<String,dynamic>>();
    return parsed.map<SearchItem>((json) => SearchItem.fromJson(json)).toList();




}


}


//sir mero chahi 2 ota problem ma cha
//sir tesma jlekhni
//problem sir