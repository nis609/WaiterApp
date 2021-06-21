import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/ui/Login.dart';

import '../size_config.dart';
import 'Home.dart';

class Areas extends StatefulWidget{
  @override
  Ar createState() => Ar();
}

class Ar extends State<Areas> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (MediaQuery
        .of(context)
        .orientation == Orientation.portrait) {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          return  DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                elevation: 8,
                title: Text('Jostish',style:TextStyle(color: Colors.black),),
                backgroundColor: Colors.blue,
                iconTheme: IconThemeData(
                  color: Colors.grey, //change your color here
                ),
                toolbarHeight: 80,
                // Set this height
                flexibleSpace: Container(
                  color: const Color(0xffffffff),

                ),
                bottom:  PreferredSize(
                  // preferredSize: new Size(200.0, 200.0),

                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 5),

                        ),
                      ),
                      Expanded(
                        child: Container(
                          //alignment: Alignment.centerLeft,
                          width: 200,
                          padding: EdgeInsets.all(8),
                          height: 50,
                          child: TabBar(

                            unselectedLabelColor: Colors.pink,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.yellow[700]

                            ),
                            tabs: [


                              Container(
                                  width: 80,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                    ,
                                    //  color: Colors.pink[100],
                                  ),
                                  margin: EdgeInsets.only(top: 5),
                                  child: Tab(child: Text(
                                    "Resturant", style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 12,
                                    color: const Color(0xff292929),
                                    fontWeight: FontWeight.w500,
                                  ),
                                    textAlign: TextAlign.left,
                                  ),)),
                              Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                    ,
                                    // color: Colors.pink[100],
                                  ),

                                  margin: EdgeInsets.only(top: 10),
                                  child: Tab(

                                    child: Text(
                                      "Dishes", style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 12,
                                      color: const Color(0xff292929),
                                      fontWeight: FontWeight.w500,
                                    ),
                                      textAlign: TextAlign.left,
                                    ),)),
                              Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                    ,
                                    // color: Colors.pink[100],
                                  ),

                                  margin: EdgeInsets.only(top: 10),
                                  child: Tab(

                                    child: Text(
                                      "Dishes", style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 12,
                                      color: const Color(0xff292929),
                                      fontWeight: FontWeight.w500,
                                    ),
                                      textAlign: TextAlign.left,
                                    ),)),Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                    ,
                                    // color: Colors.pink[100],
                                  ),

                                  margin: EdgeInsets.only(top: 10),
                                  child: Tab(

                                    child: Text(
                                      "Dishes", style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 12,
                                      color: const Color(0xff292929),
                                      fontWeight: FontWeight.w500,
                                    ),
                                      textAlign: TextAlign.left,
                                    ),)),




                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [

                ],
              ),


            ),
          );
        }
        );
      }

      );
    }
    else{
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                elevation: 8,
                title: Text('Jostish',style:TextStyle(color: Colors.black),),
                backgroundColor: Colors.blue,
                iconTheme: IconThemeData(
                  color: Colors.grey, //change your color here
                ),
                toolbarHeight: 80,
                // Set this height
                flexibleSpace: Container(
                  color: const Color(0xffffffff),

                ),
                bottom:  PreferredSize(
                  // preferredSize: new Size(200.0, 200.0),

                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 5),

                        ),
                      ),
                      Expanded(
                        child: Container(
                          //alignment: Alignment.centerLeft,
                          width: 200,
                          padding: EdgeInsets.all(8),
                          height: 50,
                          child: TabBar(

                            unselectedLabelColor: Colors.pink,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.yellow[700]

                            ),
                            tabs: [


                              Container(
                                  width: 80,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                    ,
                                    //  color: Colors.pink[100],
                                  ),
                                  margin: EdgeInsets.only(top: 5),
                                  child: Tab(child: Text(
                                    "Resturant", style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 12,
                                    color: const Color(0xff292929),
                                    fontWeight: FontWeight.w500,
                                  ),
                                    textAlign: TextAlign.left,
                                  ),)),
                              Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                    ,
                                    // color: Colors.pink[100],
                                  ),

                                  margin: EdgeInsets.only(top: 10),
                                  child: Tab(

                                    child: Text(
                                      "Dishes", style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 12,
                                      color: const Color(0xff292929),
                                      fontWeight: FontWeight.w500,
                                    ),
                                      textAlign: TextAlign.left,
                                    ),)),
                              Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                    ,
                                    // color: Colors.pink[100],
                                  ),

                                  margin: EdgeInsets.only(top: 10),
                                  child: Tab(

                                    child: Text(
                                      "Dishes", style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 12,
                                      color: const Color(0xff292929),
                                      fontWeight: FontWeight.w500,
                                    ),
                                      textAlign: TextAlign.left,
                                    ),)),Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                    ,
                                    // color: Colors.pink[100],
                                  ),

                                  margin: EdgeInsets.only(top: 10),
                                  child: Tab(

                                    child: Text(
                                      "Dishes", style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 12,
                                      color: const Color(0xff292929),
                                      fontWeight: FontWeight.w500,
                                    ),
                                      textAlign: TextAlign.left,
                                    ),)),




                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [
              //    Home(),

                ],
              ),


            ),
          );
        }
        );
      }

      );
    }

  }
}
