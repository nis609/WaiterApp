import 'dart:convert';
import 'dart:developer';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_svg/svg.dart';

import 'package:restaurant/ReactiveData/MenuDetailItem.dart';

import 'package:restaurant/Services/GetItemModifierServices.dart';
import 'package:restaurant/Services/checkService.dart';
import 'package:restaurant/Services/getCommenetServices.dart';
import 'package:restaurant/Services/getTablePreviousOrderForNewKOTService.dart';
import 'package:restaurant/Services/saveOderService.dart';
import 'package:restaurant/modal/GetAllModal.dart';
import 'package:restaurant/modal/GetCloseTable.dart';
import 'package:restaurant/modal/GetItemDetail.dart';
import 'package:restaurant/modal/GetItemModifier.dart';

import 'package:restaurant/modal/getComment.dart';

import 'package:restaurant/modal/getTablePreviousOrderForNewKOTModal.dart';
import 'package:restaurant/modal/saveOrderModel.dart';
import 'package:restaurant/size_config.dart';
import 'package:restaurant/ui/Home.dart';

import 'package:restaurant/ui/menu.dart' as menu;

import 'A.dart';


class MyAppss extends StatefulWidget {
  List<menu.MyItems> menuItems = <menu.MyItems>[];
  final CloseTable closeTable;
  final GetAllTableData allTableData;
  final int userId;
  final String Username;
  final int userIdForAlltable;
  final String UsernameForAlltable;
  final String openTableName;
  final int userIdForOpentable;
  final int userIdForPriousListtable;
  final String UsernameForOpentable;
  final double previousOpenAmount;
  final double previousAllTableAmount;
  final int tableIdOfAllTable;
  final String tableNameOfAllTable;
  MyAppss({Key key, this.previousAllTableAmount,this.previousOpenAmount,this.closeTable,this.allTableData, this.userId,this.Username,this.userIdForAlltable,this.UsernameForAlltable,this.userIdForOpentable,this.UsernameForOpentable, this.openTableName,this.userIdForPriousListtable,this.tableIdOfAllTable,this.tableNameOfAllTable}) : super(key: key);


  @override
  _TableExample createState() => _TableExample();
}

class _TableExample extends State<MyAppss> {

  bool mo = false;
  GetComment noComment;
  int _counter = 0;
  int a = 0;
  int SubMenuIdForClosedTable;
  int SubMenuIdForOpenTable;
  int SubMenuIdForAllTable;
  int SubMenuIdForAllUsernameTable;
  double sum=0  ;
  double sumOfAll;
  double sumOfCloseTable=0;
  double tota;
  bool viewVisible = false ;
  int itemIdForCLosedTable;
  var menuItem;
  double total;
  Widget buildCLoseTotalsOfTables(){

    return StreamBuilder<List<ItemData>>(
        stream: menudetailitem.orderitemStream,
        builder: (context, snapshot) {

          if(snapshot.hasData){
            this.sumOfCloseTable=snapshot.data.fold(0, (a, b){


              return a + b.rate * b.qty ;

            });
          }
          return Container(


            height: 7 * Config.textMultipier,

            width: 25 * Config.textMultipier,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 3),
            child: Row(
              children: [
                Text(
                  "Rs.",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 3 * Config.textMultipier),
                ),

                Container(
                  width: 20 * Config.textMultipier,
                  child: Text(

                    //sir yesma problem ayerako cha sir
                    //sir mailae ta kunai defect dekhina sir
                    this.sumOfCloseTable == null  ||     this.sumOfCloseTable.toString() == "null" ? 0.toString():        this.sumOfCloseTable.toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 5 * Config.textMultipier),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
  Widget buildCLoseTotals(){

    return StreamBuilder<List<ItemData>>(
        stream: menudetailitem.orderitemStream,
        builder: (context, snapshot) {

          if(snapshot.hasData){
            this.sum=snapshot.data.fold(0, (a, b){

              if(widget.previousOpenAmount!=null) {
                return a + b.rate * b.qty ;
              }else{

                return a + b.rate * b.qty ;
              }
            });
          }
          return Container(

            width: 25 * Config.textMultipier,
            height: 7 * Config.textMultipier,

            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 3),
            child: Row(
              children: [
                Text(
                  "Rs.",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 3 * Config.textMultipier),
                ),

                Container(

                  child: Text(

                    //sir yesma problem ayerako cha sir
                    //sir mailae ta kunai defect dekhina sir
                    this.sum == null  ||     this.sum.toString() == "null" ? widget.previousOpenAmount:        this.sum.toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 5 * Config.textMultipier),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
  Widget buildAllTotals(){

    return StreamBuilder<List<ItemData>>(
        stream: menudetailitem.orderitemStream,
        builder: (context, snapshot) {

          if(snapshot.hasData){
            sumOfAll=snapshot.data.fold(0, (a, b){


              if(widget.previousAllTableAmount!=null) {
                return a + b.rate * b.qty +widget.previousAllTableAmount;
              }else{

                return a + b.rate * b.qty ;
              }
            });
          }
          return Container(

            width: 20 * Config.textMultipier,
            height: 7 * Config.textMultipier,



            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 3),
            child: Row(
              children: [
                Container(

                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Rs.",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 3 * Config.textMultipier),
                  ),
                ),
                Container(
                  width: 18 * Config.textMultipier,

                  child: Text(

                    //sir yesma problem ayerako cha sir
                    //sir mailae ta kunai defect dekhina sir
                    sumOfAll == null  ||     this.sum.toString() == "null" ? widget.previousAllTableAmount.toString():        sumOfAll.toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 5* Config.textMultipier),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
  Widget buildOpenTotal(){

    return StreamBuilder<List<ItemData>>(
        stream: menudetailitem.orderitemStream,
        builder: (context, snapshot) {

          if(snapshot.hasData){
            total=snapshot.data.fold(0, (a, b){

              if(widget.previousOpenAmount!=null) {
                return a + b.rate * b.qty + widget.previousOpenAmount;
              }else{

                return widget.previousOpenAmount;
              }
            });
          }
          return Container(

            width: 25 * Config.textMultipier,
            height: 7 * Config.textMultipier,


            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 3),
            child: Row(
              children: [
                Text(
                  "RS",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 3 * Config.textMultipier),
                ),
                Text(

                  //sir yesma problem ayerako cha sir
                  //sir mailae ta kunai defect dekhina sir
                  total == null  || total.toString() == "null" ? widget.previousOpenAmount.toString():    total.toString(),
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 5 * Config.textMultipier),
                ),

              ],
            ),
          );
        }
    );
  }
  int currentCommendIndex;
  ItemData closeitem;

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
  Future<List<ItemModifier>> getItemModifier(int subMenuIdForModifier) async {
    try {

      return await GetItemModifierServices().getItemModifier(subMenuIdForModifier);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }
  Future<GetItemModifier> getItemModifiers(int subMenuIdForModifier) async {
    try {

      return await GetItemModifierServices().getItemModifiers(subMenuIdForModifier);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  Future<List<Comments>> getComment(int subMenuId) async {
    if(viewVisible==true){
      try {


        return await getCommentServices().getComentDetail(subMenuId);
      } catch (SocketExcpetion) {
        print(SocketExcpetion);
      }
    }

  }
  Future<GetComment> getComments(int subMenuId) async {
    try {

      return await getCommentServices().getComentDetails(subMenuId);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }
  addComment(int parentIndex, ItemData menuItem){
    this.currentCommendIndex= parentIndex;
    closeitem=menuItem;
    setState(() {
      viewVisible = true ;
    });
  }



  // Future<List<ItemData>> getalltabbles() async {
  //   try {
  //
  //     return await GetItemDetailServices().getall();
  //   } catch (SocketExcpetion) {
  //     print(SocketExcpetion);
  //   }
  // }
  Future<List<PreviousList>> getPreviousItem(int tableId) async {
    try {

      return await getTablePreviousOrderForNewKOTService().getPrviousList(tableId);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }
  //sir 1 min aba ma yo function rakhchu ani error hernus hai
  Future<SaveModalOrder> saveListOfOrder(String tableName ,int userId,int tableId,List<ItemData> itemdata,String Username) async {
    try {

      return await SaveOrderService().saveOrderData(tableName, userId, tableId, itemdata,Username);
    } catch (Excpetion) {
      print(Excpetion);
    }
  }
  Future<SaveModalOrder> saveListOfOrders(String tableName ,int userId,int tableId,List<ItemData> itemdata) async {
    try {

      return await checkService().saveOrderDatas(tableName, userId, tableId, itemdata);
    } catch (Excpetion) {
      print(Excpetion);
    }
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          title: Container(
              height: 5 * Config.blockSizeVertical,
              width: 50 * Config.blockSizeVertical,
              //   color: Colors.blue,
              child: Text('Add modifier')),
          content: SingleChildScrollView(
              child: Container(
                height: 40 * Config.blockSizeVertical,
                width: 50 * Config.blockSizeVertical,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)),
                          padding: EdgeInsets.all(5),
                          width: 15 * Config.textMultipier,
                          height: 15 * Config.textMultipier,
                          child: Column(
                            children: [
                              Container(
                                  height: 11 * Config.textMultipier,
                                  width: 8 * Config.textMultipier,
                                  child: Center(child: Text("Extra Sauce"))),
                              Container(
                                child: Text("D1"),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          actions: <Widget>[
            Row(
              children: [
                Container(
                  color: Colors.purple,
                  child: TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      Dialog();
                    },
                  ),
                ),
                Container(
                  color: Colors.deepOrangeAccent,
                  child: TextButton(
                    child: Text('Save'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  child: TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> Dialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          title: Center(child: Text('Item  modifier Add on')),
          content: SingleChildScrollView(
              child: SizedBox(
                width: 40 * Config.textMultipier,
                height: 30 * Config.textMultipier,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: 20 * Config.textMultipier,
                          padding: EdgeInsets.all(1 * Config.textMultipier),
                          child: TextFormField(
                            onTap: () {
                              // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Country())));
                            },
                            decoration: InputDecoration(
                                labelText: "Enter yourname",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Container(
                          width: 15 * Config.textMultipier,
                          padding: EdgeInsets.all(1 * Config.textMultipier),
                          child: TextFormField(
                            onTap: () {
                              // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Country())));
                            },
                            decoration: InputDecoration(
                                labelText: "Enter Price",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.add_circle_outlined,
                            size: 5 * Config.textMultipier,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 40 * Config.textMultipier,
                      height: 20 * Config.textMultipier,
                      color: Colors.grey[200],
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Item name"),
                              ),
                              // SizedBox(
                              //   width: 1*Config.textMultipier,
                              //   height: 1*Config.textMultipier,
                              //   child: Container(
                              //     color: Colors.red,
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: Text("Price"),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Item name"),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Price"),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          actions: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(1 * Config.textMultipier),
                  color: Colors.purple,
                  child: TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      Dialog();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(1 * Config.textMultipier),
                  color: Colors.deepOrangeAccent,
                  child: TextButton(
                    child: Text('Save'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(1 * Config.textMultipier),
                  color: Colors.yellow[400],
                  child: TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }


  Future<void> addItemModifier(int parentIndex, ItemData menuItem) async {
    final GetItemModifier user = await getItemModifiers(menuItem.id);
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          //backgroundColor: Colors.blue,
          title: Container(
              height:10 * Config.blockSizeVertical,
              width: 50 * Config.blockSizeVertical,
              //    color:Colors.blue ,
              child: Text(
                'Add modifier',
                style: TextStyle(color: Colors.blue),
              )),
          content: SingleChildScrollView(
              child: Container(
                height: 40 * Config.blockSizeVertical,
                width: 80 * Config.blockSizeVertical,
                child: Column(
                  children: [

                    Container(
                      width: 80 * Config.textMultipier,
                      height: 37 * Config.textMultipier,
                      child: Column(
                        children: [
                          Container(
                            height: 35 * Config.blockSizeHorizental,
                            child: FutureBuilder<List<ItemModifier>>(
                                future: getItemModifier(menuItem.id),
                                builder: (context, snapshot) {
                                  try {

                                    print(user.data.isEmpty);
                                    print(snapshot.hasData);
                                    if (snapshot.hasData) {
                                      final us = snapshot.data;

                                      if(user.data.isEmpty){
                                        return Center(child: Text("NoItemModifierAdded"));
                                      }
                                      return ListView.builder(
                                        controller: new ScrollController(
                                            keepScrollOffset: false),
                                        scrollDirection: Axis.vertical,
                                        itemCount: us.length,
                                        itemBuilder:
                                            (BuildContext context, int listIndex) {
                                          final alll = us[listIndex];

                                          return InkWell(
                                            onTap: () {
                                              ItemData data = new ItemData();
                                              List<ItemData>getitem = [];
                                              final duplicateItem = getitem.firstWhere(
                                                      (item) => item.id == us[listIndex].id, orElse: () => null);
                                              if(duplicateItem!=null){
                                                duplicateItem.qty++;
                                              }else {
                                                data.itemName = alll.name;
                                                data.qty = 1;
                                                data.rate = alll.extraPrice;
                                                data.subTotal =
                                                    data.qty * data.rate;
                                                data.isModifier = true;
                                                data.id = menuItem.id;
                                                data.modifierId = alll.id;
                                              }


                                              getitem = menudetailitem.allItemsDetail ?? [];
                                              getitem.insert(
                                                  parentIndex + 1, data);

                                              menudetailitem.addOrder(getitem);

                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blueAccent)),
                                              width: 15 *
                                                  Config.blockSizeVertical,
                                              height:
                                              25 * Config.blockSizeHorizental,
                                              margin: EdgeInsets.only(
                                                  left: .2 * Config.textMultipier,
                                                  top: .5 * Config.textMultipier),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    //margin: EdgeInsets.only(top:3*Config.blockSizeHorizental),
                                                      child:
                                                      Text(alll.name ?? "jjj")),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: .5 *
                                                            Config
                                                                .blockSizeHorizental),
                                                    color: Colors.blue,
                                                    child: Text(alll.extraPrice
                                                        .toString() ??
                                                        "kjik"),
                                                  )
                                                ],
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

                                  return CircularProgressIndicator();
                                }),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    margin: EdgeInsets.all(5),
                    color: Colors.cyan[300],
                    child: TextButton(
                      child: Text('OK', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    color: Color.fromRGBO(0, 153, 204, 01),
                    child: TextButton(
                      child: Text('Close', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ).then((value) {
      setState(() { });
    });
  }

  Future<void> land() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          title: Center(
              child: Text('Item  modifier Add on',
                  style: TextStyle(
                    fontFamily: 'Noto Sans',
                  ))),
          content: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: .1 * Config.textMultipier,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                    width: 60 * Config.textMultipier,
                    height: 35 * Config.textMultipier,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              width: 25 * Config.textMultipier,
                              padding: EdgeInsets.all(1 * Config.textMultipier),
                              child: TextFormField(
                                onTap: () {
                                  // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Country())));
                                },
                                style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                ),
                                decoration: InputDecoration(
                                    labelText: "Enter yourname",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10))),
                              ),
                            ),
                            Container(
                              width: 20 * Config.textMultipier,
                              padding: EdgeInsets.all(1 * Config.textMultipier),
                              child: TextFormField(
                                onTap: () {
                                  // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Country())));
                                },
                                decoration: InputDecoration(
                                    labelText: "Enter Price",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10))),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.add_circle_outlined,
                                size: 5 * Config.textMultipier,
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 55 * Config.textMultipier,
                          height: 20 * Config.textMultipier,
                          color: Colors.grey[200],
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text("Item name"),
                                  ),
                                  // SizedBox(
                                  //   width: 1*Config.textMultipier,
                                  //   height: 1*Config.textMultipier,
                                  //   child: Container(
                                  //     color: Colors.red,
                                  //   ),
                                  // ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("Price"),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text("Item name"),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("Price"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: .1 * Config.textMultipier,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ],
              )),
          actions: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(1 * Config.textMultipier),
                  color: Color.fromRGBO(180, 0, 0, 01),
                  child: TextButton(
                    child: Text('Add', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Dialog();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(1 * Config.textMultipier),
                  color: Colors.cyan[300],
                  child: TextButton(
                    child: Text('Save', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(1 * Config.textMultipier),
                  color: Color.fromRGBO(0, 153, 204, 01),
                  child: TextButton(
                    child: Text('Close', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }


  void _incrementCounter(ItemData menuitems, int streamIndex) {
    var list = menudetailitem.allItemsDetail;
    var count = menuitems.qty ?? 1;
    menuitems.qty = count + 1;

    list.removeAt(streamIndex);
    list.insert(streamIndex, menuitems);
    menudetailitem.addOrder(list);

    // setState(() {
    //
    //   _counter++;
    // });
    //   setState(() {
    //     // This call to setState tells the Flutter framework that something has
    //     // changed in this State, which causes it to rerun the build method below
    //     // so that the display can reflect the updated values. If we changed
    //     // _counter without calling setState(), then the build method would not be
    //     // called again, and so nothing would appear to happen.
    //     number++;
    //     return number;
    //   });
  }

  void _decrementCounter(ItemData menuitems, int streamIndex) {
    var list = menudetailitem.allItemsDetail;
    var count = menuitems.qty ;
    menuitems.qty = count - 1;
    if(
    menuitems.qty<1
    ){
      menuitems.qty=1 ;
    }
    list.removeAt(streamIndex);
    list.insert(streamIndex, menuitems);
    menudetailitem.addOrder(list);
  }
  @override
  void setState(fn) {
    // TODO: implement setState

    super.setState(fn);

    viewVisible ;

  }




  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          return Scaffold(
            body: SingleChildScrollView(
              //  scrollDirection: Axis.vertical,
                child: Container(
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(1 * Config.blockSizeHorizental),
                      child: Row(
                        children: [
                          Expanded(child: Text("Server:Esan")),
                          Expanded(child: Text("Table:D3")),
                          Expanded(child: Text("Guest:D3")),
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
                      width: 500,
                      height: 60,
                      margin: EdgeInsets.all(1 * Config.textMultipier),
                      child: Row(
                        children: [
                          Container(
                            child: Center(
                                child: Text(
                                  "Order No",
                                  style:
                                  TextStyle(fontSize: 2 * Config.textMultipier),
                                )),
                            width: 12 * Config.blockSizeHorizental,
                            height: 10 * Config.blockSizeHorizental,
                            // color: Colors.red,
                          ),
                          Container(
                            width: 15 * Config.blockSizeHorizental,
                            height: 10 * Config.blockSizeHorizental,
                            child: Center(
                                child: Text("Item Name",
                                    style: TextStyle(
                                        fontSize: 2 * Config.textMultipier))),
                          ),
                          Container(
                              width: 10 * Config.blockSizeHorizental,
                              height: 10 * Config.blockSizeHorizental,
                              child: Center(
                                  child: Text('$_counter',
                                      style: TextStyle(
                                          fontSize:
                                          2 * Config.textMultipier)))),
                          Container(
                              width: 15 * Config.blockSizeHorizental,
                              height: 10 * Config.blockSizeHorizental,
                              child: Center(
                                  child: Text("Price",
                                      style: TextStyle(
                                          fontSize:
                                          2 * Config.textMultipier)))),
                          Container(
                              width: 13 * Config.blockSizeHorizental,
                              height: 10 * Config.blockSizeHorizental,
                              child: Center(
                                  child: Text("Sub Total",
                                      style: TextStyle(
                                          fontSize:
                                          2 * Config.textMultipier)))),
                          Container(
                              width: 15 * Config.blockSizeHorizental,
                              height: 10 * Config.blockSizeHorizental,
                              child: Center(
                                  child: Text("Price",
                                      style: TextStyle(
                                          fontSize:
                                          2 * Config.textMultipier)))),
                          Container(
                              width: 15 * Config.blockSizeHorizental,
                              height: 10 * Config.blockSizeHorizental,
                              child: Center(
                                  child: Text("Price",
                                      style: TextStyle(
                                          fontSize:
                                          2 * Config.textMultipier)))),
                        ],
                      ),
                    ),
                    // Container(
                    //   width: 150,
                    //   height: 100,
                    //   child: FutureBuilder<List<ItemData>>(
                    //       future: getalltabbles(),
                    //       builder: (context, snapshot) {
                    //         try {
                    //           print("as");
                    //
                    //           print(snapshot.hasData);
                    //
                    //           if (snapshot.hasData) {
                    //             final us = snapshot.data;
                    //
                    //             print("aaa");
                    //
                    //             return ListView.builder(
                    //               controller: new ScrollController(
                    //                   keepScrollOffset: false),
                    //
                    //               //scrollDirection: Axis.horizontal,
                    //
                    //               itemCount: us == null ? "0" : us.length,
                    //
                    //               itemBuilder:
                    //                   (BuildContext context, int index) {
                    //                 final all = us[index];
                    //
                    //                 print("not");
                    //
                    //                 return Container(
                    //                   width: 150,
                    //                   height: 30,
                    //                   child: Row(
                    //                     children: [
                    //                       Container(
                    //                         //  color: Colors.black,
                    //                         child: Text(all.itemName ?? "as"),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 );
                    //               },
                    //             );
                    //
                    //             ///print(us.data);
                    //
                    //             //return(Home());
                    //
                    //           }
                    //         } catch (SocketException) {
                    //           print(Exception);
                    //         }
                    //
                    //         return CircularProgressIndicator();
                    //       }),
                    // ),
                    Container(
                      color: Colors.white,
                      height: 50 * Config.textMultipier,
                      width: 50 * Config.textMultipier,
                      child: Column(
                        children: [
                          Container(
                            width: 50 * Config.textMultipier,
                            decoration: BoxDecoration(
                              border: Border.all(
                                //color: Colors.black,

                              ),
                              color: Colors.white,
                            ),
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(left: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Total :",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 3 * Config.textMultipier),
                                ),
                                Text(
                                  "700",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 5 * Config.textMultipier),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(1 * Config.textMultipier),
                            child: RaisedButton(
                              color: Color.fromRGBO(120, 0, 0, 01),
                              child: Container(
                                  width: 20 * Config.textMultipier,
                                  height: 7 * Config.textMultipier,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Save and Bill",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              onPressed: () {
                                //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                              },
                            ),
                          ),
                          Container(
                            //  margin: EdgeInsets.only(top:5*Config.textMultipier),
                            margin: EdgeInsets.all(1 * Config.textMultipier),
                            child: RaisedButton(
                              color: Colors.cyan[300],
                              child: Container(
                                  width: 20 * Config.textMultipier,
                                  height: 7 * Config.textMultipier,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Save Only",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              onPressed: () {
                                ///Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                              },
                            ),
                          ),
                          Container(
                            //margin: EdgeInsets.only(top:5*Config.textMultipier),
                            margin: EdgeInsets.all(1 * Config.textMultipier),
                            child: RaisedButton(
                              color: Color.fromRGBO(0, 153, 204, 01),
                              child: Container(
                                  width: 20 * Config.textMultipier,
                                  height: 7 * Config.textMultipier,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Print And Save",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              onPressed: () {
                                //  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                )),
          );
        });
      });
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          if(widget.closeTable!=null){
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  width: 99 * Config.blockSizeVertical,
                  child: SingleChildScrollView(
                    //scrollDirection: Axis.vertical,
                      child: Container(
                        width: 99 * Config.blockSizeVertical,
                        decoration:
                        BoxDecoration(border: Border.all(color: Colors.green)),
                        child: Column(children: <Widget>[
                          Container(

                            width: 99 * Config.blockSizeVertical,
                            margin: EdgeInsets.all(1 * Config.blockSizeHorizental),
                            child: Row(
                              children: [
                                Expanded(child: Text("Server:"+widget.Username??"hbhb")),

                                Expanded(child:

                                Text("TableName:"+widget.closeTable.id.toString()??"hjbn")),
                                Expanded(child: Text("Guest:D3")),
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
                            height: 30,
                            width: 99 * Config.blockSizeVertical,
                            // margin: EdgeInsets.all(1.5 * Config.blockSizeHorizental),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(

                                    child: Center(
                                        child: Text("ItemName",
                                            style: TextStyle(
                                                fontSize:15))),
                                  ),
                                  flex: 4,
                                ),
                                Expanded(

                                  child: Container(

                                    child: Center(
                                        child: Text("Qty",
                                            style: TextStyle(
                                                fontSize:
                                                15))),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(

                                      child: Center(
                                          child: Text("Rate".toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                  15)))),flex: 2,
                                ),
                                Expanded(
                                  child: Container(

                                      child: Center(
                                          child: Text("Sub Total",
                                              style: TextStyle(
                                                  fontSize:
                                                  15)))),flex: 2,
                                ),
                                Expanded(child: Container(),flex: 8,)

                              ],
                            ),
                          ),

                          Container(

                            width: 99 * Config.blockSizeVertical,
                            height: 70 * Config.blockSizeHorizental,
                            //margin: EdgeInsets.all(1 * Config.textMultipier),
                            child:StreamBuilder<List<ItemData>>(
                                stream: menudetailitem.orderitemStream,

                                builder: (context, snapshot) {
                                  //final in
                                  try {

                                    if (snapshot.hasData) {
                                      final use = snapshot.data;
                                      //display yesma bayera ho sir
                                      //agiko ma add matra bayerako ho
                                      return ListView.builder(

                                        itemCount: use.length,
                                        itemBuilder:
                                            (BuildContext context, int streamIndex) {
                                          final menuitems = use[streamIndex];




                                          if (menuitems.qty == null) {
                                          } else {

                                            menuitems.subTotal =
                                                menuitems.qty * menuitems.rate;
                                            this.sum =use.fold(0, (a, b){

                                              this.sum=a+b.rate*b.qty;

                                              return this.sum;

                                            });


                                            // sum=total??'0';



                                          }


                                          return InkWell(

                                            child: Container(
                                              width: 99 * Config.blockSizeVertical,
                                              height: 50,
                                              //color: Colors.black,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(

                                                        alignment: Alignment.centerLeft,
                                                        child:menuitems.isModifier==true? Text(
                                                            "*"+ menuitems.itemName,
                                                            style: TextStyle(
                                                                fontSize: 2 *
                                                                    Config
                                                                        .textMultipier)):Text(
                                                            menuitems.itemName??menuitems.comment,
                                                            style: TextStyle(
                                                                fontSize: 15))
                                                    ),
                                                    flex: 4,
                                                  ),
                                                  Expanded(
                                                    child: Container(

                                                        child: Center(
                                                            child: Text(
                                                                menuitems.qty == null
                                                                    ? "0"
                                                                    : menuitems.qty
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:15)))),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: Container(

                                                        child: Center(
                                                            child: Text(
                                                                menuitems.rate
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:15)))),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: Container(

                                                        child: Center(
                                                            child: Text(
                                                                menuitems.subTotal ==
                                                                    null
                                                                    ? '0'
                                                                    : menuitems
                                                                    .subTotal
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 15)))),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      child: Container(

                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                              "assets/ad.svg",
                                                              color: Colors.green),
                                                        ),

                                                      ),
                                                      onTap: () {
                                                        setState(() {  _incrementCounter(
                                                            menuitems, streamIndex);});

                                                      },
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      child: Container(

                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                              "assets/mm.svg",
                                                              color: Colors.red),
                                                        ),

                                                      ),
                                                      onTap: () {
                                                        //_counter++;

                                                        _decrementCounter(
                                                            menuitems, streamIndex);
                                                        setState(() {});
                                                      },
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        try{

                                                          menuitems.isModifier==false?addItemModifier(streamIndex,menuitems)

                                                              :


                                                          print("invalid")
                                                          ;
                                                        }catch(Exception){
                                                          print(Exception);

                                                        }

                                                      },
                                                      child: Container(


                                                        child: Center(
                                                          child: menuitems.isModifier==false?SvgPicture.asset(
                                                            "assets/hh.svg",
                                                            color: Colors.green,
                                                          ):Container(),
                                                        ),
                                                      ),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      child: Container(


                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                              "assets/yy.svg",
                                                              color: Colors.red),
                                                        ),
                                                      ),
                                                      onTap: () {

                                                        setState(() {
                                                          if(use[streamIndex].isModifier==true||use[streamIndex].isComment==true){
                                                            use.removeAt(streamIndex);
                                                          }else{
                                                            use.removeWhere((element) => element.id==use[streamIndex].id||use[streamIndex].isComment==true);

                                                          }



                                                        }
                                                        );
                                                      },
                                                    ),
                                                    flex: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {

                                              setState(() {  this.itemIdForCLosedTable=menuitems.id;  this.SubMenuIdForClosedTable=menuitems.subMenuId;});
                                              addComment(streamIndex,menuitems);

                                            },
                                          );
                                        },
                                      );


                                    }


                                  } catch (Exception) {
                                    print(Exception);
                                  }

                                  return Center(child: CircularProgressIndicator(
                                    backgroundColor: Colors.yellow,

                                  ));
                                }),
                          ),

                          Container(
                            width: 99 * Config.blockSizeVertical,
                            height:30,
                            child: Visibility(
                              //yo visibilty show huncha

                              child: Expanded(

                                child: FutureBuilder<List<Comments>>(
                                    future: getComment(this.SubMenuIdForClosedTable),
                                    builder: (context, snapshot)
                                    {
                                      final commentIndex= snapshot.data;
                                      if(snapshot.hasData){
                                        if(commentIndex.isEmpty){
                                          return Text("noComments");
                                        }else{
                                          return ListView.builder(
                                              controller: new ScrollController(keepScrollOffset: false),
                                              // scrollDirection: Axis.vertical,
                                              itemCount: commentIndex == null ? 0 : commentIndex.length,
                                              scrollDirection: Axis.horizontal,


                                              itemBuilder: (BuildContext context,int index) {

                                                final comment = commentIndex[index];

                                                return InkWell(
                                                  onTap: (){
                                                    //yespachi extra sugarcall garna bitikai yo process suru huncha

                                                    // sweet sugar vanne yei Itemdate
                                                    // //ho?
                                                    //ho sir
                                                    List<ItemData>getitem =[];
                                                    final duplicateItem = getitem.firstWhere(
                                                            (item) => item.id == commentIndex[index].id, orElse: () => null);
                                                    ItemData data = new ItemData();
                                                    if(duplicateItem.qty!=null){
                                                      duplicateItem.qty++;

                                                    }else{

                                                      data.isComment=true;
                                                      data.id=this.itemIdForCLosedTable;
                                                      data.comment=comment.comment;
                                                      data.commentId=comment.id;
                                                      data.qty=1;
                                                      data.rate=0;
                                                    }


                                                    getitem= menudetailitem.allItemsDetail??[];
                                                    getitem.insert(currentCommendIndex+1, data);

                                                    menudetailitem.addOrder(getitem);
                                                  },
                                                  child: Container(
                                                    width: 20 * Config.blockSizeVertical,
                                                    height: 25,
                                                    child:
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: Container( width: 10 * Config.blockSizeVertical,child: Text(comment.comment??"bgb")),
                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                          );}
                                      }else{
                                        return Center(child: CircularProgressIndicator());
                                      }


                                    }),
                              ),
                              visible: viewVisible,
                            ),
                          ),


                          SizedBox(
                            height: 1,
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 10 * Config.textMultipier,
                            width: 98 * Config.textMultipier,
                            child: Row(
                              children: [
                                Expanded(child: buildCLoseTotals(),flex:4,),
                                Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(1 * Config.textMultipier),
                                      child: RaisedButton(
                                        color: Color.fromRGBO(180, 0, 0, 01),
                                        child: Container(
                                            width: 13 * Config.textMultipier,
                                            height: 7 * Config.textMultipier,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Save & Bill",
                                              style: TextStyle(color: Colors.white ,fontSize:
                                              2 * Config.textMultipier),
                                            )),
                                        onPressed: () async{

                                          final SaveModalOrder saveOrder=await SaveOrderService().saveOrderData(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail,widget.Username);
                                          //saveListOfOrder(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail);


                                          if(saveOrder.message=="Success"){
                                            menudetailitem.dispose();
                                            return  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(A(tableIdForCloseTable:widget.closeTable.id,useridForCloseTable: widget.userId,))));
                                          }else{
                                            return Text("Failed");
                                          }

                                          //
                                          // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));


                                        },
                                      ),
                                    ),flex:3
                                ),

                                Expanded(
                                    child: Container(
                                      //  margin: EdgeInsets.only(top:5*Config.textMultipier),
                                      margin: EdgeInsets.all(1 * Config.textMultipier),
                                      child: RaisedButton(
                                          color: Colors.cyan[300],
                                          child: Container(
                                              width: 13 * Config.textMultipier,
                                              height: 7 * Config.textMultipier,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Save Only",
                                                style: TextStyle(color: Colors.white, fontSize:
                                                2 * Config.textMultipier),
                                              )),
                                          onPressed: () async {
                                            ///Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                            final SaveModalOrder saveOrder=await SaveOrderService().saveOrderData(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail,widget.Username);
                                            //saveListOfOrder(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail);

                                            if(saveOrder.message=="Success"){
                                              menudetailitem.dispose();
                                              return Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                            }else{
                                              return Text("Failed");
                                            }}
                                      ),
                                    ),flex:3
                                ),
                                Expanded(
                                    child: Container(
                                      //margin: EdgeInsets.only(top:5*Config.textMultipier),
                                      margin: EdgeInsets.all(1 * Config.textMultipier),
                                      child: RaisedButton(
                                        color: Color.fromRGBO(0, 153, 204, 01),
                                        child: Container(
                                            width: 13* Config.textMultipier,
                                            height: 7 * Config.textMultipier,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Print & Save",
                                              style: TextStyle(color: Colors.white, fontSize:
                                              2 * Config.textMultipier),
                                            )),
                                        onPressed: () {
                                          //  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                        },
                                      ),
                                    ),flex:3
                                ),
                              ],
                            ),
                          )
                        ]),
                      )),
                ),
              ),
            );
          }
          else if(widget.allTableData!=null){
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  width: 99 * Config.blockSizeVertical,
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
                  child: Column(children: <Widget>[
                    Container(
                      height: 15,
                      margin: EdgeInsets.all(1 * Config.blockSizeHorizental),
                      child: Row(
                        children: [
                          Expanded(child: Text(widget.UsernameForAlltable??"hbhb")),

                          Expanded(child:

                          Text("TableName:"+widget.allTableData.name??"hjbn")),
                          Expanded(child: Text("Guest:D3")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: 15,
                      width: 99 * Config.blockSizeVertical,
                      // margin: EdgeInsets.all(1.5 * Config.blockSizeHorizental),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(

                              child: Center(
                                  child: Text("ItemName",
                                      style: TextStyle(
                                          fontSize:15))),
                            ),
                            flex: 4,
                          ),
                          Expanded(

                            child: Container(

                              child: Center(
                                  child: Text("Qty",
                                      style: TextStyle(
                                          fontSize:
                                          15))),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Container(

                                child: Center(
                                    child: Text("Rate".toString(),
                                        style: TextStyle(
                                            fontSize:
                                            15)))),flex: 2,
                          ),
                          Expanded(
                            child: Container(

                                child: Center(
                                    child: Text("Sub Total",
                                        style: TextStyle(
                                            fontSize:
                                            15)))),flex: 2,
                          ),
                          Expanded(child: Container(),flex: 8,)

                        ],
                      ),
                    ),

                    Container(

                      width: 99 * Config.blockSizeVertical,
                      height: 68 * Config.blockSizeHorizental,
                      margin: EdgeInsets.all(1 * Config.textMultipier),
                      child: StreamBuilder<List<ItemData>>(
                          stream: menudetailitem.orderitemStream,
                          builder: (context, snapshot) {
                            //final in
                            try {

                              if (snapshot.hasData) {
                                final use = snapshot.data;

                                return ListView.builder(
                                  itemCount: use.length,
                                  itemBuilder:
                                      (BuildContext context, int streamIndex) {
                                    final menuitems = use[streamIndex];



                                    int a = 0;

                                    if (menuitems.qty == null) {
                                    } else {

                                      menuitems.subTotal =
                                          menuitems.qty * menuitems.rate;
                                      sum =use.fold(0, (a, b){


                                        return a+b.rate??'1'*b.qty;

                                      });



                                    }



                                    return Container(
                                      width: 99 * Config.blockSizeVertical,
                                      height: 40,
                                      color: menuitems.isModifier==true?Colors.grey[300]:Colors.white,
                                      child: Column(
                                        children: [
                                          InkWell(

                                            child: Container(
                                              width: 99 * Config.blockSizeVertical,
                                              height:  40,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(


                                                      child:menuitems.isModifier==true? Text(
                                                          "*"+ menuitems.itemName,
                                                          style: TextStyle(
                                                              fontSize: 2 *
                                                                  Config
                                                                      .textMultipier)):Text(
                                                          menuitems.itemName??menuitems.comment,
                                                          style: TextStyle(
                                                              fontSize:15)),
                                                    ),
                                                    flex: 4,
                                                  ),
                                                  Expanded(
                                                    child: Container(


                                                        child: Center(
                                                            child: Text(
                                                                menuitems.qty == null
                                                                    ? "0"
                                                                    : menuitems.qty
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 15)))),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: Container(


                                                        child: Center(
                                                            child: Text(
                                                                menuitems.rate
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:15)))), flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: Container(


                                                        child: Center(
                                                            child: Text(
                                                                menuitems.subTotal ==
                                                                    null
                                                                    ? '0'
                                                                    : menuitems
                                                                    .subTotal
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:15)))), flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      child:  Container(


                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                              "assets/ad.svg",
                                                              color: Colors.green),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {  _incrementCounter(
                                                            menuitems, streamIndex);});

                                                      },
                                                    ), flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      child: Container(


                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                              "assets/mm.svg",
                                                              color: Colors.red),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        //_counter++;

                                                        _decrementCounter(
                                                            menuitems, streamIndex);
                                                        setState(() {});
                                                      },
                                                    ), flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        try{

                                                          menuitems.isModifier==false?addItemModifier(streamIndex,menuitems)

                                                              :


                                                          print("invalid")
                                                          ;
                                                        }catch(Exception){
                                                          print(Exception);

                                                        }

                                                      },
                                                      child: Container(


                                                        child: Center(
                                                          child: menuitems.isModifier==false?SvgPicture.asset(
                                                            "assets/hh.svg",
                                                            color: Colors.green,
                                                          ):Container(),
                                                        ),
                                                      ),
                                                    ), flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      child: Container(


                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                              "assets/yy.svg",
                                                              color: Colors.red),
                                                        ),
                                                      ),
                                                      onTap: () {

                                                        setState(() {
                                                          if(use[streamIndex].isModifier==true||use[streamIndex].isComment==true){
                                                            use.removeAt(streamIndex);
                                                          }else{
                                                            use.removeWhere((element) => element.id==use[streamIndex].id);

                                                          }




                                                        }
                                                        );
                                                      },
                                                    ), flex: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: (){
                                              //yo listview ma click garna bitikai y
                                              addComment(streamIndex,menuitems);
                                              setState(() {  this.itemIdForCLosedTable=menuitems.id;
                                              this.SubMenuIdForAllUsernameTable=menuitems.subMenuId;
                                              });

                                            },
                                          ),


                                        ],
                                      ),
                                    );
                                  },
                                );


                              }
                            } catch (Exception) {
                              print(Exception);
                            }

                            return Center(child: CircularProgressIndicator(
                              backgroundColor: Colors.yellow,

                            ));
                          }),
                    ),

                    SizedBox(
                      height: 1,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 99 * Config.blockSizeVertical,
                      height: 30,
                      child: Visibility(
                        //yo visibilty show huncha

                        child: Container(
                          width: 99 * Config.blockSizeVertical,
                          height: 25,
                          child: FutureBuilder<List<Comments>>(
                              future: getComment(this.SubMenuIdForAllUsernameTable),
                              builder: (context, snapshot)
                              {
                                final commentIndex= snapshot.data;
                                if(snapshot.hasData){
                                  if(commentIndex.isEmpty){
                                    return Center(child: Text("No Comment"));
                                  }else {
                                    return ListView.builder(
                                        controller: new ScrollController(
                                            keepScrollOffset: false),
                                        // scrollDirection: Axis.vertical,
                                        itemCount: commentIndex == null
                                            ? 0
                                            : commentIndex.length,
                                        scrollDirection: Axis.horizontal,


                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          final comment = commentIndex[index];
                                          return InkWell(
                                            onTap: () {
                                              //yespachi extra sugarcall garna bitikai yo process suru huncha

                                              // sweet sugar vanne yei Itemdate
                                              // //ho?
                                              //ho sir
                                              List<ItemData>getitem =[];
                                              final duplicateItem = getitem.firstWhere(
                                                      (item) => item.id == commentIndex[index].id, orElse: () => null);
                                              ItemData data = new ItemData();
                                              if(duplicateItem.qty!=null){
                                                duplicateItem.qty++;

                                              }else{

                                                data.isComment=true;
                                                data.id=this.itemIdForCLosedTable;
                                                data.comment=comment.comment;
                                                data.commentId=comment.id;
                                                data.qty=1;
                                                data.rate=0;
                                              }
                                              getitem =
                                                  menudetailitem.allItemsDetail ??
                                                      [];
                                              getitem.insert(
                                                  currentCommendIndex + 1, data);

                                              menudetailitem.addOrder(getitem);
                                            },
                                            child: Container(
                                              width: 20 *
                                                  Config.blockSizeVertical,
                                              height: 25 *
                                                  Config.blockSizeHorizental,
                                              child:
                                              Row(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                        comment.comment ?? "bgb"),
                                                  )

                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                  }}else{
                                  return Center(child: CircularProgressIndicator());
                                }


                              }),
                        ),
                        visible: viewVisible,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),



                    Container(
                      color: Colors.white,
                      height: 10 * Config.textMultipier,
                      width: 99 * Config.textMultipier,
                      child: Row(
                        children: [
                          Expanded(child: buildCLoseTotalsOfTables(),flex:4),
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.all(1 * Config.textMultipier),
                                child: RaisedButton(
                                  color: Color.fromRGBO(180, 0, 0, 01),
                                  child: Container(
                                      width: 20 * Config.textMultipier,
                                      height: 7 * Config.textMultipier,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Save and Bill",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  onPressed: () async {
                                    final SaveModalOrder saveOrder=await SaveOrderService().saveOrderData(widget.allTableData.name, widget.userIdForAlltable, widget.allTableData.id, menudetailitem.allItemsDetail,widget.UsernameForAlltable);
                                    //saveListOfOrder(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail);



                                    if(saveOrder.message=="Success"){
                                      menudetailitem.dispose();
                                      //   return  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(A(tableIdForUsernameAllTable: widget.allTableData.id,useridForUsernameAllTable:widget.userIdForAlltable,))));
                                    }else{
                                      return Text("Failed");
                                    }

                                    Navigator.push(context, new MaterialPageRoute(builder: (context)=>(A(tableIdForUsernameAllTable: widget.allTableData.id,useridForUsernameAllTable:widget.userIdForAlltable,))));

                                    //menudetailitem.dispose();
                                    // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                  },
                                ),
                              ),flex:3
                          ),
                          Expanded(
                              child: Container(
                                //  margin: EdgeInsets.only(top:5*Config.textMultipier),
                                margin: EdgeInsets.all(1 * Config.textMultipier),
                                child: RaisedButton(
                                  color: Colors.cyan[300],
                                  child: Container(
                                      width: 20 * Config.textMultipier,
                                      height: 7 * Config.textMultipier,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Save Only",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  onPressed: () async {
                                    final SaveModalOrder saveOrder=await SaveOrderService().saveOrderData(widget.allTableData.name, widget.userIdForAlltable, widget.allTableData.id, menudetailitem.allItemsDetail,widget.UsernameForAlltable);
                                    //saveListOfOrder(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail);


                                    if(saveOrder.message=="Success"){
                                      menudetailitem.dispose();
                                      return Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                    }else{
                                      return Text("Failed");
                                    }
                                    print("asdas");
                                  },
                                ),
                              ),flex:3
                          ),
                          Expanded(
                              child: Container(
                                //margin: EdgeInsets.only(top:5*Config.textMultipier),
                                margin: EdgeInsets.all(1 * Config.textMultipier),
                                child: RaisedButton(
                                  color: Color.fromRGBO(0, 153, 204, 01),
                                  child: Container(
                                      width: 20 * Config.textMultipier,
                                      height: 7 * Config.textMultipier,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Print And Save",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  onPressed: () {
                                    //  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                  },
                                ),
                              ),flex:3
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            );
          }else{
            if(widget.UsernameForAlltable!=null){
              return Scaffold(
                backgroundColor: Colors.white,
                body: Container(

                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
                  height:  99 * Config.blockSizeHorizental,
                  width:  99 * Config.blockSizeVertical,
                  child: Column(children: <Widget>[
                    Container(
                      height: 15,
                      margin: EdgeInsets.all(1 * Config.blockSizeHorizental),
                      child: Row(
                        children: [
                          Expanded(child: Text("Server:"+widget.UsernameForAlltable.toString()??"hbhb")),

                          Expanded(child:

                          Text("Table:"+widget.tableIdOfAllTable.toString()??"bh")),
                          Expanded(child: Text("Guest:D3")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 99 * Config.blockSizeVertical,
                      margin: EdgeInsets.all(1 * Config.blockSizeHorizental),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(


                              child: Center(
                                  child: Text("ItemName",
                                      style: TextStyle(
                                          fontSize:15))),
                            )
                            ,
                            flex: 4,
                          ),
                          Expanded(
                            child: Container(


                                child: Center(
                                    child: Text("Qty",
                                        style: TextStyle(
                                            fontSize:
                                            15)))),
                            flex: 2,
                          ),
                          Expanded(
                            child: Container(


                                child: Center(
                                    child: Text("Rate".toString(),
                                        style: TextStyle(
                                            fontSize:
                                            15)))),
                            flex: 2,
                          ),

                          Expanded(
                            child: Container(


                                child: Center(
                                    child: Text("Sub Total",
                                        style: TextStyle(
                                            fontSize:
                                            15)))),
                            flex: 2,
                          ),
                          Expanded(child: Container(),flex: 8,)

                        ],
                      ),
                    ),

                    Column(
                      children: [
                        Container(
                          width: 99 * Config.blockSizeVertical,
                          height: 150,

                          //    color: Colors.grey,
                          child: FutureBuilder<List<PreviousList>>(
                              future: getPreviousItem( widget.tableIdOfAllTable),
                              builder: (context, snapshot) {
                                try {

                                  // yeha display vairako ho?
                                  //hajur sir
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int previousMenuItemIndex) {
                                        final previousMenuItem = snapshot.data[previousMenuItemIndex];

                                        previousMenuItem.subTotal=previousMenuItem.rate*previousMenuItem.qty;



                                        return Container(
                                          width: 99 * Config.blockSizeVertical,
                                          height: 10 * Config.blockSizeHorizental,
                                          color: previousMenuItem.isModifier==false?Colors.grey[300]:Colors.white,
                                          child: Column(
                                            children: [
                                              InkWell(

                                                child: Container(
                                                  width: 99 * Config.blockSizeVertical,
                                                  height: 10 * Config.blockSizeHorizental,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.centerLeft,

                                                          child: previousMenuItem.isModifier==false? Text(
                                                              previousMenuItem.itemName,
                                                              style: TextStyle(
                                                                  fontSize: 15)):Text(
                                                              previousMenuItem.itemName??previousMenuItem.comment,
                                                              style: TextStyle(
                                                                  fontSize: 15)),
                                                        ), flex: 4,
                                                      ),
                                                      Expanded(
                                                        child: Container(

                                                            child: Center(
                                                                child: Text(
                                                                    previousMenuItem.qty == null
                                                                        ? "0"
                                                                        : previousMenuItem.qty
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:15)))), flex: 2,
                                                      ),
                                                      Expanded(
                                                        child: Container(

                                                            child: Center(
                                                                child: Text(
                                                                    previousMenuItem.rate
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: 15)))), flex: 2,
                                                      ),
                                                      Expanded(
                                                        child: Container(

                                                            child: Center(
                                                                child: Text(
                                                                    previousMenuItem.subTotal ==
                                                                        null
                                                                        ? '0'
                                                                        : previousMenuItem
                                                                        .subTotal
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:15)))),
                                                        flex: 2,
                                                      ),
                                                      Expanded(child: Container(),flex: 8,)

                                                    ],
                                                  ),
                                                ),
                                                onTap: (){
                                                  //yo listview ma click garna bitikai y
                                                  //  addComment(streamIndex,menuitems);
                                                  //addComment(streamIndex);
                                                },
                                              ),



                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }else{
                                    return Center(child: CircularProgressIndicator());
                                  }






                                  return Container();
                                } catch (Exception) {
                                  print(Exception);
                                }

                                return Container();
                              }),
                        ),
                        Container(

                          width: 99 * Config.blockSizeVertical,
                          height: 35 * Config.blockSizeHorizental,
                          margin: EdgeInsets.all(1 * Config.textMultipier),
                          child: StreamBuilder<List<ItemData>>(
                              stream: menudetailitem.orderitemStream,
                              builder: (context, snapshot) {

                                try {

                                  if (snapshot.hasData) {
                                    final use = snapshot.data;

                                    return ListView.builder(
                                      itemCount: use.length,
                                      itemBuilder:
                                          (BuildContext context, int streamIndex) {
                                        final menuitems = use[streamIndex];



                                        int a = 0;

                                        if (menuitems.qty == null) {
                                        } else {

                                          menuitems.subTotal =
                                              menuitems.qty * menuitems.rate;
                                          sum =use.fold(0, (a, b){


                                            return a+b.rate??'1'*b.qty;

                                          });

                                        }



                                        return Container(
                                          width: 99 * Config.blockSizeVertical,
                                          height: 40,
                                          color: menuitems.isModifier==true?Colors.grey[300]:Colors.white,
                                          child: Column(
                                            children: [
                                              InkWell(

                                                child: Container(
                                                  width: 100 * Config.blockSizeVertical,
                                                  height: 40,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.centerLeft,

                                                          child: menuitems.isModifier==true? Text(
                                                              "*"+ menuitems.itemName,
                                                              style: TextStyle(
                                                                  fontSize: 15)):Text(
                                                              menuitems.itemName??menuitems.comment,
                                                              style: TextStyle(
                                                                  fontSize: 15)),
                                                        ),   flex: 4,
                                                      ),
                                                      Expanded(
                                                        child: Container(


                                                            child: Center(
                                                                child: Text(
                                                                    menuitems.qty == null
                                                                        ? "0"
                                                                        : menuitems.qty
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: 15)))),   flex: 2,
                                                      ),
                                                      Expanded(
                                                        child: Container(


                                                            child: Center(
                                                                child: Text(
                                                                    menuitems.rate
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:15)))),   flex: 2,
                                                      ),
                                                      Expanded(
                                                        child: Container(


                                                            child: Center(
                                                                child: Text(
                                                                    menuitems.subTotal ==
                                                                        null
                                                                        ? '0'
                                                                        : menuitems
                                                                        .subTotal
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:15)))),   flex: 2,
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          child: Container(


                                                            child: Center(
                                                              child: SvgPicture.asset(
                                                                  "assets/ad.svg",
                                                                  color: Colors.green),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            setState(() {  _incrementCounter(
                                                                menuitems, streamIndex);});

                                                          },
                                                        ),   flex: 2,
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          child: Container(


                                                            child: Center(
                                                              child: SvgPicture.asset(
                                                                  "assets/mm.svg",
                                                                  color: Colors.red),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            //_counter++;

                                                            _decrementCounter(
                                                                menuitems, streamIndex);
                                                            setState(() {});
                                                          },
                                                        ),   flex: 2,
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            try{

                                                              menuitems.isModifier==false?addItemModifier(streamIndex,menuitems)

                                                                  :


                                                              print("invalid")
                                                              ;
                                                            }catch(Exception){
                                                              print(Exception);

                                                            }

                                                          },
                                                          child: Container(


                                                            child: Center(
                                                              child: menuitems.isModifier==false?SvgPicture.asset(
                                                                "assets/hh.svg",
                                                                color: Colors.green,
                                                              ):Container(),
                                                            ),
                                                          ),
                                                        ),   flex: 2,
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          child: Container(


                                                            child: Center(
                                                              child: SvgPicture.asset(
                                                                  "assets/yy.svg",
                                                                  color: Colors.red),
                                                            ),
                                                          ),
                                                          onTap: () {

                                                            setState(() {
                                                              if(use[streamIndex].isModifier==true||use[streamIndex].isComment==true){
                                                                use.removeAt(streamIndex);
                                                              }else{
                                                                use.removeWhere((element) => element.id==use[streamIndex].id);

                                                              }




                                                            }
                                                            );
                                                          },
                                                        ),
                                                        flex: 2,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: (){
                                                  //yo listview ma click garna bitikai y
                                                  addComment(streamIndex,menuitems);
                                                  setState(() {  this.itemIdForCLosedTable=menuitems.id;this.SubMenuIdForAllUsernameTable=menuitems.subMenuId;});
                                                  //addComment(streamIndex);
                                                },
                                              ),


                                            ],
                                          ),
                                        );
                                      },
                                    );


                                  }
                                } catch (Exception) {
                                  print(Exception);
                                }

                                return Center(child: CircularProgressIndicator(
                                  backgroundColor: Colors.yellow,

                                ));
                              }),
                        ),
                      ],
                    ),

                    Container(
                      width: 99 * Config.blockSizeVertical,
                      height: 30,
                      child: Visibility(
                        //yo visibilty show huncha

                        child: Container(
                          width: 99 * Config.blockSizeVertical,
                          height: 30,
                          child: FutureBuilder<List<Comments>>(
                              future: getComment(this.SubMenuIdForAllUsernameTable),
                              builder: (context, snapshot)
                              {
                                final commentIndex= snapshot.data;
                                if(snapshot.hasData){
                                  if(commentIndex.isEmpty){
                                    return Text("No Comment");
                                  }else{


                                    return ListView.builder(
                                        controller: new ScrollController(keepScrollOffset: false),
                                        // scrollDirection: Axis.vertical,
                                        itemCount: commentIndex == null ? 0 : commentIndex.length,
                                        scrollDirection: Axis.horizontal,


                                        itemBuilder: (BuildContext context,int index) {
                                          final comment = commentIndex[index];
                                          return InkWell(
                                            onTap: (){

                                              List<ItemData>getitem =[];
                                              final duplicateItem = getitem.firstWhere(
                                                      (item) => item.id == commentIndex[index].id, orElse: () => null);
                                              ItemData data = new ItemData();
                                              if(duplicateItem.qty!=null){
                                                duplicateItem.qty++;

                                              }else{

                                                data.isComment=true;
                                                data.id=this.itemIdForCLosedTable;
                                                data.comment=comment.comment;
                                                data.commentId=comment.id;
                                                data.qty=1;
                                                data.rate=0;
                                              }
                                              getitem= menudetailitem.allItemsDetail??[];
                                              getitem.insert(currentCommendIndex+1, data);

                                              menudetailitem.addOrder(getitem);
                                            },
                                            child: Container(
                                              width: 20 * Config.blockSizeVertical,
                                              height: 10 * Config.blockSizeHorizental,
                                              child:
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 10 * Config.blockSizeVertical,
                                                    child: Text(comment.comment??"bgb"),
                                                  )

                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                  }}else{
                                  return Center(child: CircularProgressIndicator());
                                }


                              }),
                        ),
                        visible: viewVisible,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      height: 10 * Config.textMultipier,
                      width: 100 * Config.textMultipier,
                      child: Row(
                        children: [
                          Expanded(child: buildAllTotals(),flex: 4,),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(1 * Config.textMultipier),
                              child: RaisedButton(
                                color: Color.fromRGBO(180, 0, 0, 01),
                                child: Container(
                                    width: 20 * Config.textMultipier,
                                    height: 7 * Config.textMultipier,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Save and Bill",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                onPressed: () async {


                                  final SaveModalOrder saveOrder=await SaveOrderService().saveOrderData(widget.tableNameOfAllTable, widget.userIdForAlltable, widget.tableIdOfAllTable, menudetailitem.allItemsDetail,widget.UsernameForAlltable);
                                  //saveListOfOrder(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail);


                                  if(saveOrder.message=="Success"){
                                    menudetailitem.dispose();
                                    return Navigator.push(context, new MaterialPageRoute(builder: (context)=>(A(tableIdForAllTable: widget.tableIdOfAllTable ,useridForAllTable: widget.userIdForAlltable,))));
                                  }else{
                                    return Text("Failed");
                                  }

                                  //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(A(tableIdForAllTable: widget.tableIdOfAllTable ,useridForAllTable: widget.userIdForAlltable,))));
                                  //menudetailitem.dispose();
                                  //  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                  //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                },
                              ),
                            ),flex: 3,
                          ),
                          Expanded(
                            child: Container(
                              //  margin: EdgeInsets.only(top:5*Config.textMultipier),
                              margin: EdgeInsets.all(1 * Config.textMultipier),
                              child: RaisedButton(
                                color: Colors.cyan[300],
                                child: Container(
                                    width: 20 * Config.textMultipier,
                                    height: 7 * Config.textMultipier,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Save Only",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                onPressed: () async {
                                  final SaveModalOrder saveOrder=await SaveOrderService().saveOrderData(widget.tableNameOfAllTable, widget.userIdForAlltable, widget.tableIdOfAllTable, menudetailitem.allItemsDetail,widget.UsernameForAlltable);
                                  //saveListOfOrder(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail);


                                  if(saveOrder.message=="Success"){
                                    menudetailitem.dispose();
                                    return Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                  }else{
                                    return Text("Failed");
                                  }

                                  print("asdas");
                                },
                              ),
                            ),flex: 3,
                          ),
                          Expanded(
                            child: Container(
                              //margin: EdgeInsets.only(top:5*Config.textMultipier),
                              margin: EdgeInsets.all(1 * Config.textMultipier),
                              child: RaisedButton(
                                color: Color.fromRGBO(0, 153, 204, 01),
                                child: Container(
                                    width: 20 * Config.textMultipier,
                                    height: 7 * Config.textMultipier,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Print And Save",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                onPressed: () {
                                  //  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                },
                              ),
                            ),flex: 3,
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              );
            }else{
              return Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Container(
                    width: 99 * Config.blockSizeVertical,

                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                    child: Column(children: <Widget>[
                      Container(
                        height: 15,
                        margin: EdgeInsets.all(1 * Config.blockSizeHorizental),
                        child: Row(
                          children: [
                            Expanded(child: Text("Server:"+widget.UsernameForOpentable.toString()??"hbhb")),

                            Expanded(child:

                            Text(widget.openTableName??"")),
                            Expanded(child: Text("Guest:D3")),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 5 * Config.blockSizeHorizental,
                        width: 99 * Config.blockSizeVertical,
                        margin: EdgeInsets.all(1 * Config.blockSizeHorizental),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(


                                child: Center(
                                    child: Text("ItemName",
                                        style: TextStyle(
                                            fontSize:15))),
                              )
                              ,
                              flex: 4,
                            ),
                            Expanded(
                              child: Container(


                                  child: Center(
                                      child: Text("Qty",
                                          style: TextStyle(
                                              fontSize:
                                              15)))),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(


                                  child: Center(
                                      child: Text("Rate".toString(),
                                          style: TextStyle(
                                              fontSize:
                                              15)))),
                              flex: 2,
                            ),

                            Expanded(
                              child: Container(


                                  child: Center(
                                      child: Text("Sub Total",
                                          style: TextStyle(
                                              fontSize:
                                              15)))),
                              flex: 2,
                            ),
                            Expanded(child: Container(),flex: 8,)

                          ],
                        ),
                      ),

                      Column(
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              width: 99 * Config.blockSizeVertical,
                              height: 30 * Config.blockSizeHorizental,
                              //    color: Colors.grey,
                              child: FutureBuilder<List<PreviousList>>(
                                  future: getPreviousItem( widget.userIdForPriousListtable),
                                  builder: (context, snapshot) {
                                    try {

                                      if(snapshot.hasData){
                                        return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder:
                                              (BuildContext context, int previousMenuItemIndex) {
                                            final previousMenuItem = snapshot.data[previousMenuItemIndex];



                                            if (previousMenuItem.qty == null) {}
                                            else {
                                              previousMenuItem.subTotal =
                                                  previousMenuItem.qty * previousMenuItem.rate;
                                              this.sum = snapshot.data.fold(0, (a, b) {

                                                return a + b.subTotal;
                                              });
                                              // sum=total??'0';


                                              return Container(
                                                width: 99 * Config.blockSizeVertical,
                                                height:40,
                                                color: previousMenuItem.isModifier==false?Colors.grey[300]:Colors.white,
                                                child: Column(
                                                  children: [
                                                    InkWell(

                                                      child: Container(
                                                        width: 99 * Config.blockSizeVertical,
                                                        height: 40,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                alignment:Alignment.centerLeft,
                                                                child: previousMenuItem.isModifier==false? Text(
                                                                    "*"+ previousMenuItem.itemName,
                                                                    style: TextStyle(
                                                                        fontSize: 15)):Text(
                                                                    previousMenuItem.itemName??previousMenuItem.comment,
                                                                    style: TextStyle(
                                                                        fontSize:15)),
                                                              ),
                                                              flex: 4,
                                                            ),
                                                            Expanded(
                                                              child: Container(

                                                                  child: Center(
                                                                      child: Text(
                                                                          previousMenuItem.qty == null
                                                                              ? "0"
                                                                              : previousMenuItem.qty
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize:15)))),
                                                              flex: 2,
                                                            ),
                                                            Expanded(
                                                              child: Container(

                                                                  child: Center(
                                                                      child: Text(
                                                                          previousMenuItem.rate
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 15)))),
                                                              flex: 2,
                                                            ),
                                                            Expanded(
                                                              child: Container(

                                                                  child: Center(
                                                                      child: Text(
                                                                          previousMenuItem.subTotal ==
                                                                              null
                                                                              ? '0'
                                                                              : previousMenuItem
                                                                              .subTotal
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 15)))),
                                                              flex: 2,
                                                            ),
                                                            Expanded(child: Container(),flex: 8,)

                                                          ],
                                                        ),
                                                      ),
                                                      onTap: (){
                                                        //yo listview ma click garna bitikai y
                                                        //  addComment(streamIndex,menuitems);
                                                        //addComment(streamIndex);
                                                      },
                                                    ),



                                                  ],
                                                ),
                                              );
                                            }


                                          },
                                        );
                                      }else{
                                        return Center(child: CircularProgressIndicator());
                                      }






                                      return Container();
                                    } catch (Exception) {
                                      print(Exception);
                                    }

                                    return Container();
                                  }),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(

                              width: 99 * Config.blockSizeVertical,
                              height: 30 * Config.blockSizeHorizental,
                              margin: EdgeInsets.all(1 * Config.textMultipier),
                              child: StreamBuilder<List<ItemData>>(
                                  stream: menudetailitem.orderitemStream,
                                  builder: (context, snapshot) {
                                    //final in
                                    try {

                                      if (snapshot.hasData) {
                                        final use = snapshot.data;

                                        return ListView.builder(
                                          itemCount: use.length,
                                          itemBuilder:
                                              (BuildContext context, int streamIndex) {
                                            final menuitems = use[streamIndex];




                                            int a = 0;

                                            if (menuitems.qty == null) {
                                              sum =use.fold(0, (a, b){

                                                return widget.previousOpenAmount;
                                              });
                                            }
                                            else {

                                              menuitems.subTotal =
                                                  menuitems.qty * menuitems.rate;
                                              sum =use.fold(0, (a, b){

                                                if(widget.previousOpenAmount!=null) {
                                                  return a + b.rate * b.qty + widget.previousOpenAmount;
                                                }else{

                                                  return widget.previousOpenAmount;
                                                }


                                              });
                                              // sum=total??'0';



                                            }



                                            return Container(
                                              width: 99 * Config.blockSizeVertical,
                                              height: 40,
                                              color: menuitems.isModifier==true?Colors.grey[300]:Colors.white,
                                              child: Column(
                                                children: [
                                                  InkWell(

                                                    child: Container(
                                                      width: 99 * Config.blockSizeVertical,
                                                      height: 40,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(

                                                              alignment: Alignment.centerLeft,
                                                              child: menuitems.isModifier==true? Text(
                                                                  "*"+ menuitems.itemName,
                                                                  style: TextStyle(
                                                                      fontSize: 2 *
                                                                          Config
                                                                              .textMultipier)):Text(
                                                                  menuitems.itemName??menuitems.comment,
                                                                  style: TextStyle(
                                                                      fontSize: 2 *
                                                                          Config
                                                                              .textMultipier)),
                                                            ),
                                                            flex: 4,
                                                          ),
                                                          Expanded(
                                                            child: Container(

                                                                child: Center(
                                                                    child: Text(
                                                                        menuitems.qty == null
                                                                            ? "0"
                                                                            : menuitems.qty
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: 2 *
                                                                                Config
                                                                                    .textMultipier)))),
                                                            flex: 2,
                                                          ),
                                                          Expanded(
                                                            child: Container(

                                                                child: Center(
                                                                    child: Text(
                                                                        menuitems.rate
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: 2 *
                                                                                Config
                                                                                    .textMultipier)))),
                                                            flex: 2,
                                                          ),
                                                          Expanded(
                                                            child: Container(

                                                                child: Center(
                                                                    child: Text(
                                                                        menuitems.subTotal ==
                                                                            null
                                                                            ? '0'
                                                                            : menuitems
                                                                            .subTotal
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: 2 *
                                                                                Config
                                                                                    .textMultipier)))),
                                                            flex: 2,
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              child:Container(

                                                                child: Center(
                                                                  child: SvgPicture.asset(
                                                                      "assets/ad.svg",
                                                                      color: Colors.green),
                                                                ),
                                                              ) ,
                                                              onTap: () {
                                                                setState(() {  _incrementCounter(
                                                                    menuitems, streamIndex);});

                                                              },
                                                            ),
                                                            flex: 2,
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              child: Container(

                                                                child: Center(
                                                                  child: SvgPicture.asset(
                                                                      "assets/mm.svg",
                                                                      color: Colors.red),
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                //_counter++;

                                                                _decrementCounter(
                                                                    menuitems, streamIndex);
                                                                setState(() {});
                                                              },
                                                            ),
                                                            flex: 2,
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                try{

                                                                  menuitems.isModifier==false?addItemModifier(streamIndex,menuitems)

                                                                      :


                                                                  print("invalid")
                                                                  ;
                                                                }catch(Exception){
                                                                  print(Exception);

                                                                }

                                                              },
                                                              child: Container(

                                                                child: Center(
                                                                  child: menuitems.isModifier==false?SvgPicture.asset(
                                                                    "assets/hh.svg",
                                                                    color: Colors.green,
                                                                  ):Container(),
                                                                ),
                                                              ),
                                                            ),
                                                            flex: 2,
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              child: Container(
                                                                width: 12 *
                                                                    Config
                                                                        .blockSizeHorizental,
                                                                height: 15 *
                                                                    Config
                                                                        .blockSizeHorizental,
                                                                child: Center(
                                                                  child: SvgPicture.asset(
                                                                      "assets/yy.svg",
                                                                      color: Colors.red),
                                                                ),
                                                              ),
                                                              onTap: () {

                                                                setState(() {
                                                                  if(use[streamIndex].isModifier==true||use[streamIndex].isComment==true){
                                                                    use.removeAt(streamIndex);
                                                                  }else{
                                                                    use.removeWhere((element) => element.id==use[streamIndex].id);

                                                                  }




                                                                }
                                                                );
                                                              },
                                                            ),
                                                            flex: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: (){
                                                      //yo listview ma click garna bitikai y
                                                      addComment(streamIndex,menuitems);
                                                      setState(() {  this.itemIdForCLosedTable=menuitems.id; this.SubMenuIdForOpenTable=menuitems.subMenuId;});
                                                      //addComment(streamIndex);
                                                    },
                                                  ),


                                                ],
                                              ),
                                            );
                                          },
                                        );


                                      }
                                    } catch (Exception) {
                                      print(Exception);
                                    }

                                    return Center(child: CircularProgressIndicator(
                                      backgroundColor: Colors.yellow,

                                    ));
                                  }),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: 99 * Config.blockSizeVertical,
                        height: 10 * Config.blockSizeHorizental,
                        child: Visibility(
                          //yo visibilty show huncha

                          child: Container(
                            width: 99 * Config.blockSizeVertical,
                            height: 10 * Config.blockSizeHorizental,
                            child:viewVisible==true? FutureBuilder<List<Comments>>(
                                future: getComment(this.SubMenuIdForOpenTable),
                                builder: (context, snapshot)
                                {
                                  final commentIndex= snapshot.data;
                                  if(snapshot.hasData){
                                    if(commentIndex.isEmpty){
                                      return Center(child: Text("No Comments"));
                                    }else{
                                      return ListView.builder(
                                          controller: new ScrollController(keepScrollOffset: false),
                                          // scrollDirection: Axis.vertical,
                                          itemCount: commentIndex == null ? 0 : commentIndex.length,
                                          scrollDirection: Axis.horizontal,


                                          itemBuilder: (BuildContext context,int index) {
                                            final comment = commentIndex[index];
                                            return InkWell(
                                              onTap: (){
                                                //yespachi extra sugarcall garna bitikai yo process suru huncha

                                                // sweet sugar vanne yei Itemdate
                                                // //ho?
                                                //ho sir
                                                ItemData data = new ItemData();
                                                data.id=this.itemIdForCLosedTable;
                                                data.isComment=true;
                                                data.comment=comment.comment;
                                                data.commentId=comment.id;
                                                data.qty=1;
                                                data.rate=1;

                                                List<ItemData>getitem =[];
                                                getitem= menudetailitem.allItemsDetail??[];
                                                getitem.insert(currentCommendIndex+1, data);

                                                menudetailitem.addOrder(getitem);
                                              },
                                              child: Container(
                                                width: 20 * Config.blockSizeVertical,
                                                height: 10 * Config.blockSizeHorizental,
                                                child:
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Text(comment.comment??"bgb"),
                                                    )

                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                      );
                                    }}else{
                                    return Center(child: CircularProgressIndicator());
                                  }


                                }):Container(),
                          ),
                          visible: viewVisible,
                        ),
                      ),

                      SizedBox(
                        height:1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 10 * Config.textMultipier,
                        width: 99 * Config.textMultipier,
                        child: Row(
                          children: [
                            Expanded(child: buildOpenTotal(),flex: 4,),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(1 * Config.textMultipier),
                                child: RaisedButton(
                                  color: Color.fromRGBO(180, 0, 0, 01),
                                  child: Container(
                                      width: 20 * Config.textMultipier,
                                      height: 7 * Config.textMultipier,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Save and Bill",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  onPressed: () async {
                                    final SaveModalOrder saveOrder=await SaveOrderService().saveOrderData(widget.openTableName, widget.userIdForOpentable, widget.userIdForPriousListtable, menudetailitem.allItemsDetail,widget.UsernameForOpentable);
                                    //saveListOfOrder(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail);


                                    if(saveOrder.message=="Success"){

                                      return Navigator.push(context, new MaterialPageRoute(builder: (context)=>(A(tableIdForOpenTable:widget.userIdForPriousListtable ,useridForOpenTable:widget.userIdForOpentable,))));
                                      menudetailitem.dispose();
                                    }else{
                                      return Text("Failed");
                                    }
                                    // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(A(tableIdForOpenTable:widget.userIdForPriousListtable ,useridForOpenTable:widget.userIdForOpentable,))));

                                  },
                                ),
                              ),flex: 3,
                            ),
                            Expanded(
                              child: Container(
                                //  margin: EdgeInsets.only(top:5*Config.textMultipier),
                                margin: EdgeInsets.all(1 * Config.textMultipier),
                                child: RaisedButton(
                                  color: Colors.cyan[300],
                                  child: Container(
                                      width: 20 * Config.textMultipier,
                                      height: 7 * Config.textMultipier,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Save Only",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  onPressed: () async {
                                    final SaveModalOrder saveOrder=await SaveOrderService().saveOrderData(widget.openTableName, widget.userIdForOpentable, widget.userIdForPriousListtable, menudetailitem.allItemsDetail,widget.UsernameForOpentable);
                                    //saveListOfOrder(widget.closeTable.name, widget.userId, widget.closeTable.id, menudetailitem.allItemsDetail);


                                    if(saveOrder.message=="Success"){
                                      menudetailitem.dispose();
                                      return Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                    }else{
                                      return Text("Failed");
                                    }

                                    print("asdas");
                                  },
                                ),
                              ),flex: 3,
                            ),
                            Expanded(
                              child: Container(
                                //margin: EdgeInsets.only(top:5*Config.textMultipier),
                                margin: EdgeInsets.all(1 * Config.textMultipier),
                                child: RaisedButton(
                                  color: Color.fromRGBO(0, 153, 204, 01),
                                  child: Container(
                                      width: 20 * Config.textMultipier,
                                      height: 7 * Config.textMultipier,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Print And Save",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  onPressed: () {
                                    //  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                  },
                                ),
                              ),flex: 3,
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              );
            }

          }



        });
      });
    }
  }
}

