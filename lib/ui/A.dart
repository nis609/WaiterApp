import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/ReactiveData/reactive_userName.dart';
import 'package:restaurant/Services/CheckOutServices.dart';
import 'package:restaurant/Services/GetTotalBillsService.dart';
import 'package:restaurant/Services/billPaymentModeService.dart';

import 'package:restaurant/Services/getCreditorBillservices.dart';
import 'package:restaurant/modal/CheckOut.dart';
import 'package:restaurant/modal/GetTotalBills.dart';
import 'package:restaurant/modal/billPaymentMode.dart';
import 'package:restaurant/modal/getCreditorBill.dart';

import '../size_config.dart';
import 'Home.dart';

class A extends StatefulWidget {
  final int tableIdForOpenTable;
  final int tableIdForCloseTable;
  final int useridForOpenTable;
  final int useridForUsernameAllTable;
  final int useridForCloseTable;
  final int useridForAllTable;


  final int tableIdForAllTable;
  final int tableIdForUsernameAllTable;


  const A(
      {Key key, this.tableIdForUsernameAllTable, this.tableIdForOpenTable, this.tableIdForCloseTable, this.useridForOpenTable, this.useridForCloseTable, this.tableIdForAllTable, this.useridForAllTable, this.useridForUsernameAllTable})
      : super(key: key);


  @override
  _AState createState() => _AState();
}

class _AState extends State<A> with SingleTickerProviderStateMixin {
  CreditorBill _rtx;
  int UserID;

  CreditorBill get rtn {
    if (rtn == null) {
      _rtx = CreditorBill(); // Instantiate the object if its null.
    }
    return _rtx;
  }
  int _counter = 0;
  TextEditingController searchItemNamesController = new TextEditingController();
  List<CreditorBill> creditor = [];
  List<CreditorBill> creditors = [];
  String selectedValue;

  Future<List<CreditorBill>> getCreditorBillss() async {
    return await GetCreditorsBillsService().getCredtorsBills();
  }
  Future<List<ModeOfPayment>> getPayemntMode(int index) async{
    return await PayemantModeService().getPaymentMode(index);
  }

  String query = '';
  String phonenumber = '';
  bool searchloading = true;
  List <CreditorBill> doawaitedlist = [];


  TextEditingController tc = new TextEditingController();
  bool hideKeyboard = false;
  bool loading = true;
  bool loadings = true;
int tableID;
  Future<List<TotalBills>> getTotalBills(int tableId) async {
    return await GetTotalBillsService().getTotalBills(tableId);
  }

  Future<CheckOut> checkOut(int tableId, int userId,
      List<CreditorBill> creditorBill, String modeOfMayment) async {
    return await CheckOutService().getCheckout(
        tableId, userId, creditorBill, modeOfMayment);
  }

  List<CreditorBill> creditorsBillsForOpenTable = [];

  List<TotalBills> totalBillsforOpenTable = [];
  List<TotalBills> totalBillsforAllTable = [];
  List<TotalBills> totalBillsforAllsTable = [];
  List<TotalBills> totalBillsforCloseTable = [];
  double subtotal;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'MIDDLE'),
    Tab(text: 'RIGHT'),
  ];

  TabController _tabController;
  List<CreditorBill> creditorss = [];

  // List < CreditorBill > getCreditorBills(String name) =>
  //     List < CreditorBill > .from(
  //         json.decode(name).map((x) => CreditorBill.fromJson(x)));
  // String payloadToJson(List < CreditorBill > data) =>
  //     json.encode(List < dynamic > .from(data.map((x) => x.toJson())));

  GlobalKey<AutoCompleteTextFieldState<CreditorBill>> key = new GlobalKey();

  @override
  void initState() {
    super.initState();

    totalBillsforOpenTable.add(TotalBills(qty: 0,rate: 0,grandTotal: 0,item: "ass",subtTotal:0 ,total:0 ,vat: 0));
    totalBillsforAllTable.add(TotalBills(qty: 0,rate: 0,grandTotal: 0,item: "ass",subtTotal:0 ,total:0 ,vat: 0));
    totalBillsforAllsTable.add(TotalBills(qty: 0,rate: 0,grandTotal: 0,item: "ass",subtTotal:0 ,total:0 ,vat: 0));
    totalBillsforCloseTable.add(TotalBills(qty: 0,rate: 0,grandTotal: 0,item: "ass",subtTotal:0 ,total:0 ,vat: 0));
    creditorsBillsForOpenTable.add(CreditorBill(Id: "1",phone: "2"));

    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(() {
      setState(() {
        _counter = _tabController.index;
      });

    });
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    if (widget.tableIdForAllTable != null){
      setState(() {
        tableID=widget.tableIdForAllTable;
        UserID=widget.useridForAllTable;
      });
    }else if (widget.tableIdForOpenTable !=null){
      setState(() {
        tableID=widget.tableIdForOpenTable;
        UserID=widget.useridForOpenTable;
      });
    }else if(widget.tableIdForUsernameAllTable != null){
      setState(() {
        tableID=widget.tableIdForUsernameAllTable;
        UserID=widget.useridForUsernameAllTable;
      });
    }else{
      setState(() {
        tableID=widget.tableIdForCloseTable;
        UserID=widget.useridForCloseTable;
      });
    }
      return Scaffold(
      appBar: AppBar(
        title: Text("Settlement"),
        actions: <Widget>[

          new Container(),

          Center(
            child: new Text(
              tableID.toString(),
              textScaleFactor: 1.5,
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),


        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [

                    Container(
                        height: 30,

                        margin: EdgeInsets.all(
                            1 * Config.blockSizeHorizental),
                        child: Row(
                          children: [

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


                                    child: Text("Rate")),
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
                      height: 30 * Config.blockSizeVertical,
                      // width: 70 * Config.blockSizeHorizental,
                      child: this.subtotal == null ? FutureBuilder<
                          List<TotalBills>>(
                          future: getTotalBills(tableID),
                          builder: (context, snapshot) {
                            try {
                              if (snapshot.hasData) {
                                final us = snapshot.data;

                                totalBillsforOpenTable = us;
                                return ListView.builder(
                                  controller: new ScrollController(
                                      keepScrollOffset: false),
                                  // scrollDirection: Axis.vertical,
                                  itemCount: us == null ? 0 : us
                                      .length,


                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    final all = us[index];
                                    this.subtotal = all.subtTotal;
                                    //
                                    // if (all.qty == null) {}
                                    // else {
                                    //
                                    //
                                    //   // sum=total??'0';
                                    //
                                    //
                                    //   print("sum value is this ${sum
                                    //       .toString()}");
                                    // }
                                    return
                                      Container(
                                          height: 5 * Config
                                              .blockSizeVertical,
                                          width: 70 * Config
                                              .blockSizeHorizental,
                                          color: Colors.grey,
                                          margin: EdgeInsets.all(
                                              .1 * Config
                                                  .blockSizeHorizental),
                                          //margin: EdgeInsets.all(10),
                                          // margin: EdgeInsets.only(left: .1*Config.blockSizeHorizental),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(

                                                  child: Text(
                                                      all.item ??
                                                          "mmm"),

                                                ),
                                                flex: 3,
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Container(

                                                    child: Text(
                                                        all.qty
                                                            .toString()),

                                                  ),
                                                ),
                                                flex: 2,
                                              ),

                                              Expanded(
                                                child: Center(
                                                  child: Container(

                                                      child: Text(
                                                          all.rate
                                                              .toString())),
                                                ),
                                                flex: 2,
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Container(

                                                      child: Text(
                                                          all.total
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

                      ) :
                      Container(
                        height: 30 * Config.blockSizeVertical,


                        child: ListView.builder(
                          controller: new ScrollController(
                              keepScrollOffset: false),
                          // scrollDirection: Axis.vertical,
                          itemCount: totalBillsforOpenTable == null
                              ? 0
                              : totalBillsforOpenTable
                              .length,


                          itemBuilder: (BuildContext context,
                              int index) {
                            final all = totalBillsforOpenTable[index];
                            this.subtotal = all.subtTotal;
                            //
                            // if (all.qty == null) {}
                            // else {
                            //
                            //
                            //   // sum=total??'0';
                            //
                            //
                            //   print("sum value is this ${sum
                            //       .toString()}");
                            // }
                            return
                              Container(
                                  height: 5 * Config
                                      .blockSizeVertical,
                                  width: 70 * Config
                                      .blockSizeHorizental,
                                  color: Colors.grey,
                                  margin: EdgeInsets.all(
                                      .1 * Config
                                          .blockSizeHorizental),
                                  //margin: EdgeInsets.all(10),
                                  // margin: EdgeInsets.only(left: .1*Config.blockSizeHorizental),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(

                                          child: Text(
                                              all.item ??
                                                  "mmm"),

                                        ),
                                        flex: 3,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Container(

                                            child: Text(
                                                all.qty
                                                    .toString()),

                                          ),
                                        ),
                                        flex: 2,
                                      ),

                                      Expanded(
                                        child: Center(
                                          child: Container(

                                              child: Text(
                                                  all.rate
                                                      .toString())),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Container(

                                              child: Text(
                                                  all.total
                                                      .toString())),
                                        ),
                                        flex: 2,
                                      ),


                                    ],
                                  )
                              );
                          },
                        ),
                      ),
                    ),
                    Container(

                      alignment: Alignment.centerRight,
                      height: 15 * Config.textMultipier,
                      width: 50 * Config.textMultipier,
                      child: subtotal == null ? FutureBuilder<List<TotalBills>>(
                          future: getTotalBills(tableID),

                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              double sums = snapshot.data.fold(
                                  0, (a, b) {
                                return a + b.total;
                              });
                              return Container(
                                height: 200,
                                width: 40 *
                                    Config.blockSizeVertical,
                                child: Column(
                                  children: [
                                    Container(alignment: Alignment
                                        .centerRight,
                                      height: 35,
                                      width: 30 *
                                          Config.textMultipier,
                                      child: Text("Total:" +
                                          snapshot.data.first
                                              .subtTotal
                                              .toString()),),
                                    Container(alignment: Alignment
                                        .centerRight,
                                      height: 35,
                                      width: 30 *
                                          Config.textMultipier,
                                      child: Text("Vat:" +
                                          snapshot.data.first.vat
                                              .toString()),),
                                    Container(alignment: Alignment
                                        .centerRight,
                                      height: 35,
                                      width: 30 *
                                          Config.textMultipier,
                                      child: Text("Grand Total:" +
                                          snapshot.data.first
                                              .grandTotal
                                              .toString()),),
                                  ],
                                ),
                              );
                            }
                            else {
                              return Container();
                            }
                          }
                      ) :
                      Container(
                        height: 200,
                        width: 40 *
                            Config.blockSizeVertical,
                        child: Column(
                          children: [
                            Container(alignment: Alignment
                                .centerRight,
                              height: 35,
                              width: 30 *
                                  Config.textMultipier,
                              child: Text("Total:" +
                                  totalBillsforOpenTable.first.total.toString(),),),
                            Container(alignment: Alignment
                                .centerRight,
                              height: 35,
                              width: 30 *
                                  Config.textMultipier,
                              child: Text("Vat" +
                                  totalBillsforOpenTable.first.vat.toString()),),
                            Container(alignment: Alignment
                                .centerRight,
                              height: 35,
                              width: 30 *
                                  Config.textMultipier,
                              child: Text("Grand Total :" +
                                  totalBillsforOpenTable.first.grandTotal
                                      .toString()),),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Expanded(flex: 1,
            child: Container(

                child: Scaffold(
                  appBar: AppBar(

                    title: Text('Types of Payment',
                      style: TextStyle(color: Colors.black),),
                    backgroundColor: Colors.blue,
                    iconTheme: IconThemeData(
                      color: Colors
                          .grey, //change your color here
                    ),
                    toolbarHeight: 10 * Config.textMultipier,
                    // Set this height
                    flexibleSpace: Container(
                      color: const Color(0xffffffff),

                    ),
                    bottom: PreferredSize(
                      // preferredSize: new Size(200.0, 200.0),

                      child: Row(
                        children: [


                          Expanded(
                            child: Container(
                              //alignment: Alignment.centerLeft,
                              width: 10 *
                                  Config.textMultipier,
                              padding: EdgeInsets.all(8),
                              height: 5 *
                                  Config.textMultipier,
                              child: TabBar(
                                controller: _tabController,

                                unselectedLabelColor: Colors
                                    .pink,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(5),
                                    color: Colors.yellow[700]

                                ),
                                tabs: [

                                  Container(
                                      width: 10 * Config
                                          .textMultipier,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius
                                            .circular(5)
                                        ,
                                        //  color: Colors.pink[100],
                                      ),
                                      margin: EdgeInsets.only(
                                          top: 5),
                                      child: Tab(child: Text(
                                        "Credit",
                                        style: TextStyle(
                                          fontFamily: 'Noto Sans',
                                          fontSize: 12,
                                          color: const Color(
                                              0xff292929),
                                          fontWeight: FontWeight
                                              .w500,
                                        ),
                                        textAlign: TextAlign
                                            .left,
                                      ),)),
                                  Container(
                                      width: 10 * Config
                                          .textMultipier,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius
                                            .circular(5)
                                        ,
                                        // color: Colors.pink[100],
                                      ),

                                      margin: EdgeInsets.only(
                                          top: 10),
                                      child: Tab(

                                        child: Text(
                                          "Cash",
                                          style: TextStyle(
                                            fontFamily: 'Noto Sans',
                                            fontSize: 12,
                                            color: const Color(
                                                0xff292929),
                                            fontWeight: FontWeight
                                                .w500,
                                          ),
                                          textAlign: TextAlign
                                              .left,
                                        ),)),
                                  Container(
                                      width: 10 * Config
                                          .textMultipier,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius
                                            .circular(5)
                                        ,
                                        // color: Colors.pink[100],
                                      ),

                                      margin: EdgeInsets.only(
                                          top: 10),
                                      child: Tab(

                                        child: Text(
                                          "Card",
                                          style: TextStyle(
                                            fontFamily: 'Noto Sans',
                                            fontSize: 12,
                                            color: const Color(
                                                0xff292929),
                                            fontWeight: FontWeight
                                                .w500,
                                          ),
                                          textAlign: TextAlign
                                              .left,
                                        ),))


                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    controller: _tabController,
                    children: [

                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(

                                          child: Center(child: Text(
                                              "Contact Name"))),

                                      if(searchloading == false)
                                        Container(
                                          height: 150,
                                        )
                                      else
                                        Container()


                                    ],
                                  ),
                                  flex: 1,),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(10),

                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        borderRadius: BorderRadius
                                            .circular(10)
                                    ),
                                    child: Column(
                                      children: [

                                        Row(
                                          children: [
                                            if(hideKeyboard == false)
                                              Expanded(
// margin: EdgeInsets.all(10),

                                                child: TextField(

                                                    readOnly: hideKeyboard,
                                                    onTap: () {
                                                      setState(() {
                                                        hideKeyboard =
                                                        false;
                                                        searchloading =
                                                        false;
                                                        loading = false;
                                                      });
                                                    },

                                                    controller: searchItemNamesController,
                                                    maxLines: 5,
                                                    minLines: 1,

                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Search"
                                                      ,

                                                    ),

                                                    onChanged: (v) {
                                                      setState(() {
                                                        query = v;
                                                      });
                                                    }),
                                                flex: 4,
                                              ) else
                                              Expanded(
// margin: EdgeInsets.all(10),

                                                child: TextField(

                                                    readOnly: true,
                                                    onTap: () {
                                                      setState(() {
                                                        hideKeyboard =
                                                        false;
                                                        searchloading =
                                                        false;
                                                        loading = false;
                                                      });
                                                    },

                                                    controller: searchItemNamesController,
                                                    maxLines: 5,
                                                    minLines: 1,

                                                    decoration: InputDecoration(
                                                      hintText: query ??
                                                          "Search"
                                                      ,

                                                    ),

                                                    onChanged: (v) {
                                                      setState(() {
                                                        query = v;
                                                      });
                                                    }),
                                                flex: 4,
                                              ),
                                            Expanded(
                                              child: loadings == true
                                                  ? IconButton(
                                                icon: Icon(Icons
                                                    .arrow_drop_down),
                                                onPressed: () {
                                                  setState(() {
                                                    hideKeyboard = false;
                                                    searchloading =
                                                    false;
                                                    loadings = false;
                                                  });
                                                },
                                              )
                                                  :
                                              IconButton(
                                                icon: Icon(Icons
                                                    .arrow_circle_up),
                                                onPressed: () {
                                                  setState(() {
                                                    hideKeyboard = true;
                                                    searchloading =
                                                    true;
                                                    loadings = true;
                                                  });
                                                },

                                              ),
                                              flex: 1,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                                height: 2,
                                                color: Colors.white,
                                                child: loading == true
                                                    ? FutureBuilder<
                                                    List<CreditorBill>>(
                                                    future: getCreditorBillss(),
                                                    builder: (context,
                                                        snapshot) {
                                                      doawaitedlist =
                                                          snapshot.data;
                                                      return Text(
                                                          "sdsd");
                                                    }
                                                )
                                                    : Container()),
                                            if (searchloading ==
                                                false) Container(
                                                height: 150,
                                                color: Colors.black26,
                                                child: doawaitedlist !=
                                                    null ? ListView
                                                    .builder(

                                                    itemCount: doawaitedlist
                                                        .length,
                                                    itemBuilder: (con,
                                                        ind) {
                                                      if (searchItemNamesController
                                                          .text == "") {
                                                        return ListTile(
                                                            title: Text(
                                                                doawaitedlist[ind]
                                                                    .name),

                                                            onTap: () {
                                                              setState(() {
                                                                phonenumber=doawaitedlist[ind]
                                                                    .phone;
                                                                print(   phonenumber=doawaitedlist[ind]
                                                                    .phone);
                                                                print(phonenumber);
                                                                print("phonenumber");
                                                                hideKeyboard =
                                                                true;
                                                                loadings =
                                                                true;

                                                                searchloading =
                                                                true;
                                                                query =
                                                                    doawaitedlist[ind]
                                                                        .name;
                                                                searchItemNamesController
                                                                    .value =
                                                                    searchItemNamesController
                                                                        .value
                                                                        .copyWith(
                                                                        text: doawaitedlist[ind]
                                                                            .name,
                                                                        selection: TextSelection
                                                                            .collapsed(
                                                                            offset: doawaitedlist[ind]
                                                                                .name
                                                                                .length));
                                                              });
                                                            });
                                                      }

                                                      return query
                                                          .trim()
                                                          .isEmpty
                                                          ? null
                                                          : doawaitedlist[ind]
                                                          .name
                                                          .toLowerCase()
                                                          .contains(
                                                          query
                                                              .toLowerCase())
                                                          ? ListTile(
                                                          title: Text(
                                                              doawaitedlist[ind]
                                                                  .name),

                                                          onTap: () {
                                                            setState(() {
                                                              loadings =
                                                              true;

                                                              searchloading =
                                                              true;
                                                              query =
                                                                  doawaitedlist[ind]
                                                                      .name;
                                                              searchItemNamesController
                                                                  .value =
                                                                  searchItemNamesController
                                                                      .value
                                                                      .copyWith(
                                                                      text: doawaitedlist[ind]
                                                                          .name,
                                                                      selection: TextSelection
                                                                          .collapsed(
                                                                          offset: doawaitedlist[ind]
                                                                              .name
                                                                              .length));
                                                            });
                                                          })
                                                          : Container();
                                                    }) : Container())
                                            else
                                              Container(),


                                          ],
                                        ),


                                      ],
                                    ),
                                  ),

                                  flex: 2,
                                ),
                              ],
                            ),
                            Form(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(child: Text("phone Number")),
                                    flex: 1,),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 60,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(
                                          1 * Config.textMultipier),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),

                                          border: Border.all(
                                              color: Colors.black26
                                          )
                                      ),


                                      child: Text(
                                          phonenumber ?? "PhoneNumber"),

                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5 *
                                          Config.textMultipier, left: 8),
                                      alignment: Alignment.centerLeft,
                                      child: RaisedButton(

                                        color: Colors.purple,
                                        child:

                                        Container(

                                            height: 5 *
                                                Config.textMultipier,

                                            alignment: Alignment.center,
                                            child: Text("Pay Bills",
                                              style: TextStyle(
                                                  color: Colors
                                                      .white),)),
                                        onPressed: () async {
                                          //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                          CheckOut checkOuts = await checkOut(
                                              tableID,
                                              UserID,
                                              this.creditorsBillsForOpenTable,
                                              "Cash");
                                          if (checkOuts.message == "Success") {
                                            Navigator.push(context,
                                                new MaterialPageRoute(builder: (
                                                    context) => (Home())));
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                )
                              ],
                            ),
                            // DropdownSearch<CreditorBill>(
                            // label: TextEditingController(text: 'Mrs').text,
                            //   onFind: (String filter) async {
                            //     return creditorName =await getCreditorBillss();
                            //   },
                            //   onChanged: (CreditorBill data) {
                            //     ReactiveUsername.Username(data.name);
                            //   },
                            //   items:creditorName,
                            //
                            //  mode: Mode.MENU,
                            //  // searchBoxController: TextEditingController(text: 'Mrs'),
                            //
                            //
                            // )


                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Form(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(child: Text("Total Amount")),
                                  flex: 1,),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(
                                        1 * Config.textMultipier),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10),

                                        border: Border.all(
                                            color: Colors.black26
                                        )
                                    ),


                                    child: Text(
                                        totalBillsforOpenTable.first.grandTotal.toString()??'Grand Total'),

                                  ),
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                          Form(
                            child: Row(
                              children: [
                                Expanded(child: Container(
                                  margin: EdgeInsets.only(
                                      top: 5 * Config
                                          .textMultipier),
                                  child: RaisedButton(

                                    color: Colors.purple,
                                    child:

                                    Container(
                                        width: 15 * Config
                                            .textMultipier,
                                        height: 5 * Config
                                            .textMultipier,

                                        alignment: Alignment
                                            .center,
                                        child: Text("Pay Bills",
                                          style: TextStyle(
                                              color: Colors
                                                  .white),)),
                                    onPressed: () async {
                                      CheckOut checkOuts = await checkOut(
                                          tableID,
                                          UserID,
                                          creditorsBillsForOpenTable, "Cash");
                                      if (checkOuts.message == "Success") {
                                        Navigator.push(context,
                                            new MaterialPageRoute(builder: (
                                                context) => (Home())));
                                      }


                                      //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                    },
                                  ),
                                ), flex: 1,),
                                Expanded(
                                  child: Container(

                                  ),
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      Container(
                        width: 50 * Config.textMultipier,
                        height: 50,
                        // color: Colors.red,
                        child: Column(
                          children: [

                            Container(height: 50, width: 50 *
                                Config.textMultipier,
                              child: _counter == 2 ? FutureBuilder<
                                  List<ModeOfPayment>>(
                                  future: getPayemntMode(_counter),
                                  builder: (context, snapshot) {
                                    try {
                                      if (snapshot.hasData) {
                                        final closeTableIndex = snapshot.data;

                                        return ListView.builder(
                                          controller: new ScrollController(
                                              keepScrollOffset: false),
                                          scrollDirection: Axis.horizontal,

                                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          //   crossAxisCount: 4,
                                          //   mainAxisSpacing: 5.0,
                                          //   crossAxisSpacing: 5.0,
                                          //
                                          // ),
                                          itemCount: closeTableIndex == null
                                              ? 0
                                              : closeTableIndex.length,


                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final closeTableDetail = closeTableIndex[index];


                                            return Container(
                                              //  color: Colors.black,
                                              width: 100,
                                              height: 30,
                                              child: InkWell(
                                                onTap: () async {
                                                  CheckOut checkOuts = await checkOut(
                                                      tableID,
                                                      UserID,
                                                      creditorsBillsForOpenTable,
                                                      closeTableDetail.name);
                                                  if (checkOuts.message ==
                                                      "Success") {
                                                    Navigator.push(context,
                                                        new MaterialPageRoute(
                                                            builder: (
                                                                context) => (Home())));
                                                  }


                                                  // Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(closeTable:closeTableDetail,id: reactiveUserID.UserId,Username: ReactiveUsername.Username,)));

                                                },
                                                child: Center(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: .5 * Config
                                                            .blockSizeHorizental),

                                                    child: Text(
                                                        closeTableDetail.name),
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

                                    return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.yellow,

                                        ));
                                  }

                              ) : Container(

                                child: Text("Contact Names"),
                              ),
                            ),

                          ],
                        ),
                      ),


                    ],
                  ),


                )
            ),

          )
        ],
      ),
    );
  }
}
