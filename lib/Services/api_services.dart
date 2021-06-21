
import 'package:restaurant/ReactiveData/reactiveUrlSetting.dart';
import 'package:restaurant/ReactiveData/reactive_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService  {
  String token=reactiveToken.token;

//String token="Y06-pkvnmjzNQJV3OoyhxgwcPgouIPo87_nLYECmpv_us4QgKby5BFTCMzkKJwcjxzjMMZajPe7TwtfaqjXFGbB_OE4cgW4cJXKMzP9N4qIBJqv5nfB4YWt5NMXM-NUwYqHXaHcN-wIYiqOSFtVgRvUVkXIpkS9B3VFHAw4IyDBqLRg5kkHJFibfqOsptPUU471uwnauRJ3TOcUOWXDWjbOPVVu9iY5h8c42zak0eCmUxTAb7cXOkWTqqGSirZhozlLsKkFPic4a55Uf95jANgiDIdNQ36C6LIxCLC1Evwo";









  saved() async {
    // final pre =await SharedPreferences.getInstance();
    // final key='token';
    // final value=token;
    // pre.setString(key,value);

    //  var pres =await SharedPreferences.getInstance();
    //
    //
    //   var keys='token';
    //  this.token =pres.get(keys);
    // print(pres.get(keys));
    // print("token:");
    //
    // print("token:"+this.token);

//return this.token;


  }
//ma aba save button click garchu hai




//final String baseUrl ="https://4ee55b490237.ngrok.io/api";
final String baseUrl = reactiveUrl.Url+"/api";
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
}
//sir garisake yeha ta already 330 ako chha ta..tehita sir refresh vayerako chaina purai restart garnus na ek patak app

//huncha sir