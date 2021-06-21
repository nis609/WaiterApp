import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant/ReactiveData/reactiveOpenTableData.dart';
import 'package:restaurant/ReactiveData/reactiveUserId.dart';
import 'package:restaurant/ReactiveData/reactive_userName.dart';
import 'package:restaurant/Services/GetBillByIdServices.dart';
import 'package:restaurant/Services/GetOpenTableService.dart';
import 'package:restaurant/modal/GetBillById.dart';
import 'package:restaurant/modal/GetOpenTable.dart';
import 'package:restaurant/modal/LoginModal.dart';
import 'package:restaurant/ui/Bill.dart';
import 'package:restaurant/ui/Login.dart';
import 'package:restaurant/ui/Settlement.dart';
import 'package:restaurant/ui/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';
import 'A.dart';

class Opens extends StatefulWidget{
  final int userId;
  final String Username;



  const Opens({Key key, this.userId,this.Username}) : super(key: key);@override
  _OpensState createState() => _OpensState();
}

class _OpensState extends State<Opens>  {
  bool viewVisible = false ;
  int tableId;
  String tableNameForBill;
  String opentablesName;
  double sum  ;
  List<OpenTable> setOpenTableData = [];
  double sums=0;
  bool viewOpenLayout=false;
  bool halfdesign=true;
  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }
 var _selectedIndex = 0;
  Future<List<OpenTable>> getOpenTable() async{
    try{

      //print(reactiveUsername.Username+"hhbju");
      return await  GetOpenTableService().getalls();
    }catch(SocketExcpetion){
      print(SocketExcpetion);

    }
  }
  Future<List<Bills>> getBill(int tableId) async{
    if(tableId!=null)

    try{

      return await  GetBillByIdServices().getall(tableId);
    }catch(SocketExcpetion){
      print(SocketExcpetion);
    }
  }
List<Bills> bill;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (MediaQuery
    .of(context)
.orientation == Orientation.portrait) {
return LayoutBuilder(builder: (context, constraints) {
return OrientationBuilder(builder: (context, orientation) {
Config().int(constraints, orientation);
return  Scaffold(
    appBar: AppBar(
      title: Text("Open"),
      elevation: 0,
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
    body:Container(
      margin: EdgeInsets.all(3*Config.blockSizeHorizental),
      child: Column(

        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        showWidget();
                        //   Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));
                      },
                      child:Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                        ),

                        width: 15*Config.blockSizeVertical,
                        height: 25*Config.blockSizeHorizental,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                                child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

                            ),
                            InkWell(
                              child: Container(
                                  //margin: EdgeInsets.only(top:3*Config.blockSizeHorizental),
                                  child: SvgPicture.asset("assets/u.svg",height: 14*Config.imageSizeMultipier,width: 13*Config.imageSizeMultipier,alignment: Alignment.bottomCenter,color: Colors.purple,)

                              ),

                            ),
                            Container(
                              margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),
                              color: Colors.blue,
                              child: Text("D1"),
                            )


                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        showWidget();
                        //   Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));
                      },
                      child:Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                        ),
                        margin: EdgeInsets.only(left: .2*Config.textMultipier),
                        width: 15*Config.blockSizeVertical,
                        height: 25*Config.blockSizeHorizental,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                                child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

                            ),
                            InkWell(
                              child: Container(
                                //margin: EdgeInsets.only(top:3*Config.blockSizeHorizental),
                                  child: SvgPicture.asset("assets/u.svg",height: 14*Config.imageSizeMultipier,width: 13*Config.imageSizeMultipier,alignment: Alignment.bottomCenter,color: Colors.purple,)

                              ),

                            ),
                            Container(
                              margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),
                              color: Colors.blue,
                              child: Text("D1"),
                            )


                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        showWidget();
                        //   Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));
                      },
                      child:Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                        ),

                        width: 15*Config.blockSizeVertical,
                        height: 25*Config.blockSizeHorizental,
                        margin: EdgeInsets.only(left: .2*Config.textMultipier),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                                child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

                            ),
                            InkWell(
                              child: Container(
                                //margin: EdgeInsets.only(top:3*Config.blockSizeHorizental),
                                  child: SvgPicture.asset("assets/u.svg",height: 14*Config.imageSizeMultipier,width: 13*Config.imageSizeMultipier,alignment: Alignment.bottomCenter,color: Colors.purple,)

                              ),

                            ),
                            Container(
                              margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),
                              color: Colors.blue,
                              child: Text("D1"),
                            )


                          ],
                        ),
                      ),
                    ),



                  ],
                ),

              ],
            ),flex: 1,
          ),


          Row(
            children: [

            ],
          ),


        ],

      ),
    )
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
if(viewOpenLayout==true){
  return Scaffold(
      appBar: AppBar(
        title: Text("Open"),
        elevation: 0,
        actions: <Widget>[

          new Container(),

          Center(
            child: new Text(
              ReactiveUsername.Username ?? "",
              textScaleFactor: 1.5,
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),

          PopupMenuButton(
            initialValue: 2,
            onSelected: (value) {
              if (value == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }
            },
            child: Center(
                child: Icon(Icons.arrow_drop_down_circle)),
            itemBuilder: (context) {
              return List.generate(1, (index) {
                return PopupMenuItem(
                  value: index,
                  child: Text("Logout"),

                );
              });
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(3 * Config.blockSizeHorizental),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 47 * Config.blockSizeVertical,
                    child: Container(child: GridView.builder(
                      controller: new ScrollController(
                          keepScrollOffset: false),
                      scrollDirection: Axis.vertical,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,

                      ),
                      padding: EdgeInsets.all(10),
                      itemCount: setOpenTableData == null ? 0 : setOpenTableData.length,


                      itemBuilder: (BuildContext context, int index) {
                        final all = setOpenTableData[index];

                        return Container(
                          //  color: Colors.black,
                          width: 20 * Config.blockSizeVertical,
                          height: 30 * Config.blockSizeHorizental,
                          child: InkWell(
                            onTap: () {
                              showWidget();
                              setState(() {
                                // halfdesign=false;
                                tableId = all.id;
                                tableNameForBill = all.name;
                                //  opentablesName=all;
                              });

                              //Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueAccent)
                              ),

                              width: 15 * Config.blockSizeVertical,
                              height: 25 * Config.blockSizeHorizental,
                              margin: EdgeInsets.only(
                                  left: .2 * Config.textMultipier,
                                  top: .5 * Config.textMultipier),
                              child: Column(
                                children: [
                                  Container(
                                    height:5*Config.blockSizeHorizental,
                                    width: 5*Config.imageSizeMultipier,
                                    child: Visibility(

                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: 1 * Config
                                                  .blockSizeHorizental),
                                          child: SvgPicture.asset(
                                            "assets/jj.svg", height: 5 *
                                              Config.imageSizeMultipier,
                                            width: 5 * Config
                                                .imageSizeMultipier,
                                            alignment: Alignment.center,
                                            color: Colors.orangeAccent,)

                                      ),
                                      visible: all.isOpen,
                                    ),
                                  ),
                                  Container(
                                    height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,
                                    margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                                    //child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

                                  ),
                                  InkWell(
                                    child: Container(
                                      //margin: EdgeInsets.only(top:3*Config.blockSizeHorizental),
                                        child: SvgPicture.asset(
                                          "assets/u.svg", height: 14 *
                                            Config.imageSizeMultipier,
                                          width: 13 * Config
                                              .imageSizeMultipier,
                                          alignment: Alignment
                                              .bottomCenter,
                                          color: Colors.purple,)

                                    ),


                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: .5 *
                                        Config.blockSizeHorizental),
                                    color: Colors.blue,
                                    child: Text(all.name),
                                  )


                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),)
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Visibility(
                  //   maintainSize: true,
                  //    maintainAnimation: true,
                  //    maintainState: true,
                  visible: viewVisible,
                  child: Container(
                      height: 90 * Config.blockSizeHorizental,
                      width: 30 * Config.blockSizeHorizental,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.green
                          )
                      ),
                      //  margin: EdgeInsets.only(top: 50, bottom: 30),
                      child: Column(
                        children: [
                          Container(
                            height: 5 * Config.blockSizeHorizental,
                            child: Row(
                              children: [
                                Expanded(child: Text(
                                    ReactiveUsername.Username ?? "gv"),flex: 1,),
                                Expanded(child: Text(
                                    "Name:" + tableNameForBill.toString() ??
                                        "l,l"),flex: 1,),
                                Expanded(child: Text("Guest:D3"),flex: 1,),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: .1 * Config.textMultipier,
                            child: Container(
                              color: Colors.black,

                            ),
                          ),
                          Container(
                            width: 70 * Config.blockSizeHorizental,
                            height: 35 * Config.textMultipier,
                            child: Column(children: <Widget>[
                              Container(
                                  margin: EdgeInsets.all(
                                      1 * Config.blockSizeHorizental),
                                  child: Row(
                                    children: [
                                      Expanded(

                                        child: Container(

                                          child: Text("Order No"),
                                        //  width: 14 * Config.textMultipier,
                                        ),
                                        flex: 3,

                                      ),
                                      Expanded(
                                        child: Container(

                                          child: Text("Item Name"),
                                       //   width: 10 * Config.textMultipier,
                                        ),
                                        flex: 3,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Container(


                                              child: Text("Qty")),
                                        ),
                                        flex: 2,
                                      ),

                                      Expanded(
                                        child: Center(
                                          child: Container(

                                              child: Text("Sub Total")),
                                        ),
                                        flex: 2,
                                      ),


                                    ],
                                  )
                              ),
                              Container(
                                height: 20 * Config.blockSizeVertical,
                                width: 70 * Config.blockSizeHorizental,
                                child: tableId !=null?FutureBuilder<List<Bills>>(
                                    future: tableId!=null?getBill(tableId):Container(),
                                    builder: (context, snapshot) {
                                      try {

                                        if (snapshot.hasData) {
                                          final us = snapshot.data;
                                          bill=us;

                                          return ListView.builder(
                                            controller: new ScrollController(
                                                keepScrollOffset: false),
                                            // scrollDirection: Axis.vertical,
                                            itemCount: us == null ? 0 : us.length,


                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final all = us[index];

                                              if (all.qty == null) {}
                                              else {


                                                // sum=total??'0';



                                              }
                                              return
                                                Container(
                                                    height: 5 * Config.blockSizeVertical,
                                                    width: 70 * Config.blockSizeHorizental,
                                                    color: Colors.grey,
                                                    margin: EdgeInsets.all(.1 * Config.blockSizeHorizental),
                                                    //margin: EdgeInsets.all(10),
                                                    // margin: EdgeInsets.only(left: .1*Config.blockSizeHorizental),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(

                                                            child: Text(
                                                                all.order ?? "mmm"),
                                                            width: 14 * Config
                                                                .textMultipier,
                                                          ),
                                                          flex: 3,
                                                        ),
                                                        Expanded(
                                                          child: Container(

                                                            child: Text(
                                                                all.item ?? "nn"),
                                                            width: 10 * Config
                                                                .textMultipier,
                                                          ),
                                                          flex: 3,
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                            child: Container(


                                                                child: Text(all.qty
                                                                    .toString())),
                                                          ),
                                                          flex: 2,
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                            child: Container(

                                                                child: Text(all.total
                                                                    .toString())),
                                                          ),
                                                          flex: 2,
                                                        ),


                                                      ],
                                                    )
                                                );
                                            },
                                          );



                                        }
                                      } catch (SocketException) {
                                        print(Exception);
                                      }

                                      return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.yellow,

                                          ));
                                    }

                                ):Container(),
                              ),


                            ]),
                          ),
                          Container(
                            height: 5 * Config.textMultipier,
                            width: 40 * Config.textMultipier,
                            child: tableId !=null?FutureBuilder<List<Bills>>(
                              future:tableId!=null?getBill(tableId):Container(),

                              builder: (context, snapshot) {
                                if(snapshot.data!=null){
                                  sums = snapshot.data.fold(0, (a, b) {


                                    return a + b.qty*b.total;
                                  });
                                return Container(alignment: Alignment.centerRight,
                                  height: 5 * Config.textMultipier,
                                  width: 40 * Config.textMultipier,
                                  child: Text("Total:" + sums.toString()),);
                              }
                                else{
                                  return Container();
                                }
                              }
                            ):Text("ssss"),
                          ),
                          SizedBox(
                            height: .1 * Config.textMultipier,
                            child: Container(
                              color: Colors.black,

                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 1 * Config.textMultipier,
                                    left: 5 * Config.textMultipier),

                                alignment: Alignment.bottomLeft,
                                child: FloatingActionButton(
                                    heroTag: "btn2",

                                    onPressed: () {

                                      Navigator.push(context,
                                          new MaterialPageRoute(
                                              builder: (context) => (A(tableIdForOpenTable: tableId,useridForOpenTable:reactiveUserID.UserId,))));
                                    },
                                    elevation: 0,
                                    child: SvgPicture.asset("assets/cc.svg",
                                      height: 6 * Config.imageSizeMultipier,
                                      width: 6 * Config.imageSizeMultipier,
                                      alignment: Alignment.center,
                                      color: Colors.white,)

                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 1 * Config.textMultipier,
                                    left: 5 * Config.textMultipier),
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                    onPressed: () {
                                      // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Menu())));
                                    },
                                    elevation: 0,
                                    child: SvgPicture.asset("assets/ee.svg",
                                      height: 6 * Config.imageSizeMultipier,
                                      width: 6 * Config.imageSizeMultipier,
                                      alignment: Alignment.center,
                                      color: Colors.white,)

                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 1 * Config.textMultipier,
                                    left: 5 * Config.textMultipier),
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                    heroTag: "btn1",
                                    onPressed: () {
                                      Navigator.push(context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                              (Menu(userIdForOpentable: reactiveUserID.UserId,
                                                  UsernameForOpentable: ReactiveUsername
                                                      .Username,
                                                  previousAmount: sums,
                                                  openTableName: tableNameForBill,
                                                  userIdForPrevioustable: tableId))));
                                    },
                                    elevation: 0,
                                    child: SvgPicture.asset("assets/ss.svg",
                                      height: 6 * Config.imageSizeMultipier,
                                      width: 6 * Config.imageSizeMultipier,
                                      alignment: Alignment.center,
                                      color: Colors.orangeAccent,)

                                ),
                              ),

                            ],
                          ),
                        ],
                      )
                  ),

                ),
              ), flex: 1,

            ),
          ],
        ),
      )
  );
}else {

  return Scaffold(
      appBar: AppBar(
        title: Text("Open"),
        elevation: 0,
        actions: <Widget>[

          new Container(),

          Center(
            child: new Text(
              ReactiveUsername.Username  ?? "",
              textScaleFactor: 1.5,
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),

          PopupMenuButton(
            initialValue: 2,
            onSelected: (value) {
              if (value == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }
            },
            child: Center(
                child: Icon(Icons.arrow_drop_down_circle)),
            itemBuilder: (context) {
              return List.generate(1, (index) {
                return PopupMenuItem(
                  value: index,
                  child: Text("Logout"),

                );
              });
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(3 * Config.blockSizeHorizental),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height:70 * Config.blockSizeHorizental,
                    child: FutureBuilder<List<OpenTable>>(
                        future: getOpenTable(),
                        builder: (context, snapshot) {
                          try {

                            if (snapshot.hasData) {

                              final us = snapshot.data;
                              setOpenTableData=us;


                              return GridView.builder(

                                controller: new ScrollController(
                                    keepScrollOffset: false),
                                scrollDirection: Axis.vertical,

                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 5.0,

                                ),
                                itemCount: us == null ? 0 : us.length,


                                itemBuilder: (BuildContext context, int index) {
                                  final all = us[index];

                                  return Container(
                                    //  color: Colors.black,
                                    width: 20 * Config.blockSizeVertical,
                                    height: 25 * Config.blockSizeHorizental,
                                    child: InkWell(
                                      onTap: () {
                                        showWidget();
                                        setState(() {
                                          viewOpenLayout=true;

                                          tableId = all.id;
                                          tableNameForBill = all.name;
                                          //  opentablesName=all;
                                        });

                                        //Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueAccent)
                                        ),

                                        width: 15 * Config.blockSizeVertical,
                                        height: 20 * Config.blockSizeHorizental,
                                        margin: EdgeInsets.only(
                                            left: .2 * Config.textMultipier,
                                            top: .5 * Config.textMultipier),
                                        child: Column(
                                          children: [
                                            Container(
                                              height:5*Config.blockSizeHorizental,
                                              width: 5*Config.imageSizeMultipier,
                                              child: Visibility(

                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 1 * Config
                                                            .blockSizeHorizental),
                                                    child: SvgPicture.asset(
                                                      "assets/jj.svg", height: 5 *
                                                        Config.imageSizeMultipier,
                                                      width: 5 * Config
                                                          .imageSizeMultipier,
                                                      alignment: Alignment.center,
                                                      color: Colors.orangeAccent,)

                                                ),
                                                visible: all.isOpen,
                                              ),
                                            ),
                                            Container(
                                              height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,
                                              margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                                              //child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

                                            ),
                                            InkWell(
                                              child: Container(
                                                //margin: EdgeInsets.only(top:3*Config.blockSizeHorizental),
                                                  child: SvgPicture.asset(
                                                    "assets/u.svg", height: 14 *
                                                      Config.imageSizeMultipier,
                                                    width: 13 * Config
                                                        .imageSizeMultipier,
                                                    alignment: Alignment
                                                        .bottomCenter,
                                                    color: Colors.purple,)

                                              ),


                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: .5 *
                                                  Config.blockSizeHorizental),
                                              color: Colors.blue,
                                              child: Text(all.name),
                                            )


                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );

                              ///print(us.data);
                              //return(Home());

                            }
                          } catch (SocketException) {
                            print(Exception);
                          }

                          return Center(child: CircularProgressIndicator(
                            backgroundColor: Colors.yellow,

                          ));
                        }

                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      )
  );
}
}
);
}

);
}

  }
}