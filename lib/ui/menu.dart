import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant/Check.dart';
import 'package:restaurant/modal/GetAllModal.dart';
import 'package:restaurant/modal/GetBillById.dart';
import 'package:restaurant/modal/GetCloseTable.dart';
import 'package:restaurant/modal/GetOpenTable.dart';
import 'package:restaurant/ui/Bill.dart';
import 'package:restaurant/ui/Bot.dart';
import 'package:restaurant/ui/KOt.dart';
import 'package:restaurant/ui/OrderList.dart';

import '../size_config.dart';
import 'Home.dart';
import 'Login.dart';

class   Menu extends StatefulWidget{
  final CloseTable closeTable;
  final GetAllTableData tableData;

  final int id;
  final String Username;
  final int userIdForAlltable;
  final String UsernameForAlltable;
  final String openTableName;
  final int userIdForOpentable;
  final int userIdForPrevioustable;
  final String UsernameForOpentable;
final double previousAmount;
  final double previousClosedTableAmount;
  final int tableIdOfAllTable;
  final String tableNameOfAllTable;

  const Menu({Key key,this.previousClosedTableAmount,this.previousAmount,this.closeTable,this.tableData ,this.id,this.Username,this.userIdForAlltable,this.UsernameForAlltable,this.userIdForOpentable,this.UsernameForOpentable, this.openTableName,this.userIdForPrevioustable,this.tableIdOfAllTable,this.tableNameOfAllTable}) : super(key: key);
  //no you have closetable data in here
  // sir yeta batani transfer garnu parcha sir

  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  int _selectedIndex = 0;

  //int _selectedIndex = 0;
  //List<Widget> screens = [Login(),Login(),Login(),Login()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (MediaQuery
        .of(context)
        .orientation == Orientation.portrait) {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.Username),
              actions: <Widget>[

                new Container(),

                Center(
                  child: new Text(
                    "userName",
                    textScaleFactor: 1.5,
                    style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),

                new IconButton(
                  icon: new Icon(Icons.close),
                  tooltip: 'Closes application',
                  //onPressed: () => exit(0),
                ),
              ],
            ),
            body: Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        color: Colors.purple,
                        width:   35*Config.blockSizeHorizental,
                        height: 200*Config.blockSizeHorizental,
                        child: DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            appBar: AppBar(
                              elevation: 1,

                              toolbarHeight: 12*Config.blockSizeHorizental,
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
                                        //alignment: Alignment.centerLeft,
                                        width: 20*Config.blockSizeHorizental,
                                        padding: EdgeInsets.all(.5*Config.textMultipier),
                                        height: 10*Config.blockSizeHorizental,
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
                                                  border: Border.all(
                                                   color: Colors.black
                                                  )
                                                  ,
                                                  color: Colors.yellow[700],
                                                ),
                                                margin: EdgeInsets.only(top: 5),
                                                child: Tab(
                                                    child:SvgPicture.asset("assets/bb.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,)

                                                )

                                            )
                                            ,
                                            Container(
                                                width: 20*Config.blockSizeHorizental,
                                                // padding: EdgeInsets.all(8),
                                                padding: EdgeInsets.all(.5*Config.textMultipier),
                                                height: 10*Config.blockSizeHorizental,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5)
                                                  ,
                                                    border: Border.all(
                                                      color: Colors.black
                                                    ),
                                                    color: Color.fromRGBO(80, 20, 20, 01)

                                                  // color: Colors.pink[100],
                                                ),



                                                child: Tab(

                                                    child:SvgPicture.asset("assets/aa.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,)

                                                )),




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
                                Kot(),
                                Bots(),

                              ],
                            ),


                          ),
                        )
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(child: MyAppss(),flex: 2,)
              ],
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
          return Scaffold(
            appBar: AppBar(
              title: Text("OrderList"),
              actions: <Widget>[

                new Container(),


              ],
            ),
            body: Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                   //   color: Colors.purple,
                      width:   35*Config.blockSizeHorizental,
                      height: 150*Config.blockSizeHorizental,
                      child: DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          appBar: AppBar(
                            elevation: 1,

                            toolbarHeight: 12*Config.blockSizeHorizental,
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
                                      //alignment: Alignment.centerLeft,
                                      width: 20*Config.blockSizeHorizental,
                                      padding: EdgeInsets.all(.5*Config.textMultipier),
                                      height: 10*Config.blockSizeHorizental,
                                      child: TabBar(


                                        unselectedLabelColor: Colors.pink,
                                        indicator: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                        //    color: Colors.yellow[700]

                                        ),
                                       // indicatorColor: Colors.black,
                                        tabs: [


                                          Container(
                                              width: 20*Config.blockSizeHorizental,
                                              // padding: EdgeInsets.all(8),
                                              padding: EdgeInsets.all(.5*Config.textMultipier),
                                              height: 10*Config.blockSizeHorizental,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5)
                                                  ,
                                                  border: Border.all(
                                                      color: Colors.black
                                                  ),
                                                  color: Colors.yellow[700]
                                                // color: Colors.pink[100],
                                              ),


                                              child: Tab(

                                                  child:SvgPicture.asset("assets/bb.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,)


                                              )),
                                          Container(
                                              width: 20*Config.blockSizeHorizental,
                                             // padding: EdgeInsets.all(8),
                                              padding: EdgeInsets.all(.5*Config.textMultipier),
                                              height: 10*Config.blockSizeHorizental,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5)
                                                ,
                                                  border: Border.all(
                                                      color: Colors.black
                                                  ),
                                                  color: Color.fromRGBO(80, 20, 20, 01)

                                                // color: Colors.pink[100],
                                              ),


                                              child: Tab(

                                                child:SvgPicture.asset("assets/aa.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,)


                                              )),




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
                              Kotss(),
                              Bots(),

                            ],
                          ),


                        ),
                      )
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(child:  MyAppss(previousAllTableAmount:widget.previousClosedTableAmount,closeTable:widget.closeTable,allTableData:widget.tableData,userId: widget.id,Username:widget.Username ,userIdForAlltable:widget.userIdForAlltable ,UsernameForAlltable:widget.UsernameForAlltable ,
                    userIdForOpentable:widget.userIdForOpentable ,UsernameForOpentable:widget.UsernameForOpentable ,openTableName: widget.openTableName,userIdForPriousListtable:widget.userIdForPrevioustable,
                  tableIdOfAllTable:widget.tableIdOfAllTable ,tableNameOfAllTable: widget.tableNameOfAllTable,previousOpenAmount:widget.previousAmount,
                ),flex: 2,)
                // Expanded(child:  OrderList(),flex: 2,)
                //yo Myappps() bane class ma dekhunu parne hosir
                // yeha pani tesai gari a

                // ma garnu hajur check garnu hai

                // sir maile tabhujena sir same nai ho hernua hai ta data pass garne
              ],
            ),


          );
        }
        );
      }

      );
    }

  }
}


class MyItems{
  final String title;
  List<MyItems> children;
  MyItems(this.title,[this.children = const<MyItems>[] ]);

}

final List<MyItems> data=<MyItems>[
  MyItems(
      'KOt',
      <MyItems>[
        MyItems(
            'FastFood',
            <MyItems>[
              MyItems(
                  'Momo',
                  <MyItems>[
                    MyItems(
                        'Jhol momo',


                    ),
                    MyItems(
                      'Fry momo',


                    )
                  ]

              )
            ]

        )
      ]
  ),
  MyItems(
      'BOt',
      <MyItems>[
        MyItems(
            'Hard Drinks',
            <MyItems>[
              MyItems(
                  'Red label',
                  <MyItems>[
                    MyItems(
                      '30ml',


                    ),
                    MyItems(
                      '40 ml',


                    )
                  ]

              )
            ]

        )
      ]
  ),

];
class Entry extends StatelessWidget{
  const Entry(this.myitems);
  final MyItems myitems;
  Widget _builditems(MyItems root){
    if(root.children.isEmpty){
      return ListTile(
        title: Text(root.title),
      );

    }
    return ExpansionTile(
      key: PageStorageKey<MyItems>(root),

      title: Text(root.title),
      children: root.children.map<Widget>(_builditems).toList(),
    );


  }

  @override
  Widget build(BuildContext context) {

    return _builditems(myitems);
  }

}



