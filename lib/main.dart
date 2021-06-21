
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:restaurant/Check.dart';
import 'package:restaurant/modal/getCreditorBill.dart';
import 'package:restaurant/size_config.dart';
import 'package:restaurant/ui/A.dart';
import 'package:restaurant/ui/Bill.dart';
import 'package:restaurant/ui/Home.dart';

import 'package:restaurant/ui/Login.dart';
import 'package:restaurant/ui/OrderList.dart';
import 'package:restaurant/ui/Settlement.dart';
import 'package:restaurant/ui/menu.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Services/getCreditorBillservices.dart';


SharedPreferences sharedPref ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight])
      .then((_) {
    runApp( MyApp());
  });
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
           title: 'Flutter Demo',
         theme: ThemeData(

        primarySwatch: Colors.blue,
        fontFamily: "Microsofts",
      ),
          home:Login(),
    );
  }
}

