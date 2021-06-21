import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navigation_rail/navigation_rail.dart';
import 'package:restaurant/modal/GetCloseTable.dart';
import 'package:restaurant/modal/LoginModal.dart';
import 'package:restaurant/ui/Bill.dart';
import 'package:restaurant/ui/Close.dart';
import 'package:restaurant/ui/Login.dart';
import 'package:restaurant/ui/Opens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';
import 'All.dart';

class Home extends StatefulWidget {

final int id;
final String Username;


  const Home({Key key,this.id,this.Username}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> screens;

  String token;
  String values="";


  //int _selectedIndex = 0;


  int _currentIndex = 0;


  @override
  void initState() {
    super.initState();


    screens= [

      Opens(
      userId:
      widget.id,Username: widget.Username,
    ), Close(   userId:
    widget.id,Username: widget.Username), All(   userId:
    widget.id,Username: widget.Username,)];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          return Scaffold(
            body: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: NavigationRail(
                      backgroundColor: Colors.white,
                      selectedIndex: _selectedIndex,
                      selectedLabelTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.0,
                          decoration: TextDecoration.underline),
                      unselectedLabelTextStyle: TextStyle(color: Colors.yellow),
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      //groupAlignment: 1.0,
                      labelType: NavigationRailLabelType.all,

                      destinations: [
                        // NavigationRailDestination(
                        //   icon: Icon(Icons.dashboard, color: Colors.white,),
                        //   selectedIcon: Icon(Icons.dashboard, color: Colors.white,),
                        //   label: Text("Dashboard", style: TextStyle(color: Colors.white))
                        // ),
                        // NavigationRailDestination(
                        //   icon: Icon(Icons.list, color: Colors.white,),
                        //   selectedIcon: Icon(Icons.list, color: Colors.white,),
                        //   label: Text("Details", style: TextStyle(color: Colors.white))
                        // ),
                        // NavigationRailDestination(
                        //   icon: Icon(Icons.info_outline, color: Colors.white,),
                        //   selectedIcon: Icon(Icons.info, color: Colors.white,),
                        //   label: Text("About", style: TextStyle(color: Colors.white))
                        // ),
                        NavigationRailDestination(
                            icon: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: SvgPicture.asset(
                                  "assets/q.svg",
                                  height: 8 * Config.imageSizeMultipier,
                                  alignment: Alignment.bottomCenter,
                                  color: Colors.purple,
                                )),
                            label: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Text(
                             "open",
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                        NavigationRailDestination(
                            icon: Container(
                                child: SvgPicture.asset(
                              "assets/n.svg",
                              height: 10 * Config.imageSizeMultipier,
                              alignment: Alignment.bottomCenter,
                              color: Colors.purple,
                            )),
                            label: Padding(
                              padding: EdgeInsets.all(1),
                              child: RotatedBox(
                                quarterTurns: 0,
                                child: Text(
                                  "Close",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )),
                        NavigationRailDestination(
                            icon: Container(
                                child: SvgPicture.asset(
                              "assets/m.svg",
                              height: 10 * Config.imageSizeMultipier,
                              alignment: Alignment.bottomCenter,
                              color: Colors.purple,
                            )),
                            label: Padding(
                              padding: EdgeInsets.all(1),
                              child: RotatedBox(
                                quarterTurns: 0,
                                child: Text(
                                  "All",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )),

                        // NavigationRailDestination(
                        //     icon:Container(
                        //         child: SvgPicture.asset("assets/q.svg",height: 8*Config.imageSizeMultipier,alignment: Alignment.bottomCenter,color: Colors.purple,)),
                        //     label: Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 1),
                        //       child: RotatedBox(
                        //         quarterTurns: 0,
                        //         child: Text(
                        //           "Settelement",
                        //           style: TextStyle(color: Colors.black),
                        //         ),
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                  Expanded(child: screens[_selectedIndex])
                ],
              ),
            ),
          );
        });
      });
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          return Scaffold(
            body: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: NavigationRail(
                      backgroundColor: Colors.white,
                      selectedIndex: _selectedIndex,
                      selectedLabelTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.0,
                          decoration: TextDecoration.underline),
                      unselectedLabelTextStyle: TextStyle(color: Colors.yellow),
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      //groupAlignment: 1.0,
                      labelType: NavigationRailLabelType.all,

                      destinations: [

                        NavigationRailDestination(
                            icon: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: SvgPicture.asset(
                                  "assets/q.svg",
                                  height: 8 * Config.imageSizeMultipier,
                                  alignment: Alignment.bottomCenter,
                                  color: Colors.purple,
                                )),
                            label: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Text(
                                "Open",
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                        NavigationRailDestination(
                            icon: Container(
                                child: SvgPicture.asset(
                              "assets/n.svg",
                              height: 10 * Config.imageSizeMultipier,
                              alignment: Alignment.bottomCenter,
                              color: Colors.purple,
                            )),
                            label: Padding(
                              padding: EdgeInsets.all(1),
                              child: RotatedBox(
                                quarterTurns: 0,
                                child: Text(
                                  "Close",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )),
                        NavigationRailDestination(
                            icon: Container(
                                child: SvgPicture.asset(
                              "assets/m.svg",
                              height: 10 * Config.imageSizeMultipier,
                              alignment: Alignment.bottomCenter,
                              color: Colors.purple,
                            )),
                            label: Padding(
                              padding: EdgeInsets.all(1),
                              child: RotatedBox(
                                quarterTurns: 0,
                                child: Text(
                                  "All",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )),


                      ],
                    ),
                  ),
                  Expanded(child: screens[_selectedIndex])
                ],
              ),
            ),
          );
        });
      });
    }
  }
}
