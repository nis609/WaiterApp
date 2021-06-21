
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
import 'Opens.dart';

class Settle extends StatefulWidget {
  final int tableIdForOpenTable;
  final int tableIdForCloseTable;
  final int useridForOpenTable;
  final int useridForUsernameAllTable;
  final int useridForCloseTable;
  final int useridForAllTable;



  final int tableIdForAllTable;
  final int tableIdForUsernameAllTable;


  const Settle({Key key, this.tableIdForUsernameAllTable,this.tableIdForOpenTable, this.tableIdForCloseTable, this.useridForOpenTable, this.useridForCloseTable, this.tableIdForAllTable, this.useridForAllTable,  this.useridForUsernameAllTable}) : super(key: key);



  @override
  _TableExample createState() => _TableExample();
}

class _TableExample extends State<Settle> with SingleTickerProviderStateMixin{
  int _counter = 0;
  List<CreditorBill> creditorName;
  List<CreditorBill> creditorNames;
  String _selectedCompany;
  double subtotal;

  bool garndTotal=false;
  bool keyBoardHide=false;
  String query = '';
  bool searchloading = true;
  bool loadings = true;
  String phonenumber;
  String id;
  bool loading=true;
  List<TotalBills> total;
  List<ModeOfPayment>  paymenylistMethod;
  Future<List<CreditorBill>> getCreditorBills() async{

    return await GetCreditorsBillsService().getCredtorsBills();
  }

  List < CreditorBill > doawaitedlist=[];

  Future<List<ModeOfPayment>> getPayemntMode(int index) async{
    return await PayemantModeService().getPaymentMode(index);
  }
  // Future<List<CreditorBill>> getCreditorBillss(String names) async{
  //   return await GetCreditorsBillsService().getCredtorsBillss(names);
  // }

  Future<List<TotalBills>> getTotalBills(int tableId) async{
    return await GetTotalBillsService().getTotalBills(tableId);
  }
  Future<CheckOut> checkOut(int tableId,int userId,List<CreditorBill> creditorBill,String modeOfMayment) async{
    return await CheckOutService().getCheckout(tableId,userId,creditorBill,modeOfMayment);
  }

  List<CreditorBill> creditorsBillsForOpenTable=[];

  List<TotalBills> totalBillsforOpenTable=[];
  List<TotalBills> totalBillsforAllTable=[];
  List<TotalBills> totalBillsforAllsTable=[];
  List<TotalBills> totalBillsforCloseTable=[];

  TextEditingController searchItemNamesController = new TextEditingController();

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'MIDDLE'),
    Tab(text: 'RIGHT'),
  ];

  TabController _tabController;

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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (MediaQuery
        .of(context)
        .orientation == Orientation.portrait) {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          return Scaffold(
            appBar: AppBar(
              title: Text("Settlement"),
              actions: <Widget>[

                new Container(),

                Center(
                  child: new Text(
                    ReactiveUsername.Username,
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
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: 100*Config.textMultipier,
                  width:  60*Config.textMultipier,
                  padding: EdgeInsets.all(1*Config.textMultipier),
                  child: Column(
                    children: [

                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [

                            Container(
                              height: 30*Config.textMultipier,
                              width:  60*Config.textMultipier,
                              child: Column(children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top:1*Config.textMultipier),
                                    //padding: EdgeInsets.all(1*Config.textMultipier),
                                    child:Row
                                      (
                                      children: [
                                        Container(
                                            width: 15*Config.blockSizeHorizental,
                                            height: 8*Config.blockSizeHorizental,

                                            child: Center(child: Text("Order no",style:TextStyle(fontSize: 2*Config.textMultipier),))),
                                        Container(

                                          child: Center(child: Text("Item Name",style:TextStyle(fontSize: 2*Config.textMultipier),)),
                                          width: 20*Config.blockSizeHorizental,
                                          height: 8*Config.blockSizeHorizental,
                                          //color: Colors.red,
                                        ),
                                        Container(
                                            width: 10*Config.blockSizeHorizental,
                                            height: 8*Config.blockSizeHorizental,

                                            child: Center(child: Text("Qty",style:TextStyle(fontSize: 2*Config.textMultipier),))),
                                        Container(
                                            width: 12*Config.blockSizeHorizental,
                                            height: 8*Config.blockSizeHorizental,
                                            child: Center(child: Text("Price",style:TextStyle(fontSize: 2*Config.textMultipier),))),
                                        Container(
                                            width: 20*Config.blockSizeHorizental,
                                            height: 8*Config.blockSizeHorizental,
                                            child: Center(child: Text("Sub Total",style:TextStyle(fontSize: 2*Config.textMultipier),))),


                                      ],
                                    )
                                ),
                                Container(
                                  // margin: EdgeInsets.all(1*Config.textMultipier),
                                  //padding: EdgeInsets.all(1*Config.textMultipier),
                                    child:Row
                                      (
                                      children: [
                                        Container(
                                            width: 15*Config.blockSizeHorizental,
                                            height: 5*Config.blockSizeHorizental,

                                            child: Center(child: Text("Order no",style:TextStyle(fontSize: 2*Config.textMultipier),))),
                                        Container(

                                          child: Center(child: Text("Item Name",style:TextStyle(fontSize: 2*Config.textMultipier),)),
                                          width: 20*Config.blockSizeHorizental,
                                          height: 5*Config.blockSizeHorizental,
                                          //color: Colors.red,
                                        ),
                                        Container(
                                            width: 10*Config.blockSizeHorizental,
                                            height: 5*Config.blockSizeHorizental,

                                            child: Center(child: Text("Qty",style:TextStyle(fontSize: 2*Config.textMultipier),))),
                                        Container(
                                            width: 12*Config.blockSizeHorizental,
                                            height: 5*Config.blockSizeHorizental,
                                            child: Center(child: Text("Price",style:TextStyle(fontSize: 2*Config.textMultipier),))),
                                        Container(
                                            width: 20*Config.blockSizeHorizental,
                                            height: 5*Config.blockSizeHorizental,
                                            child: Center(child: Text("Sub Total",style:TextStyle(fontSize: 2*Config.textMultipier),))),


                                      ],
                                    )
                                ),
                                Container(
                                  // margin: EdgeInsets.all(1*Config.textMultipier),
                                  //padding: EdgeInsets.all(1*Config.textMultipier),
                                    child:Row
                                      (
                                      children: [
                                        Container(
                                            width: 15*Config.blockSizeHorizental,
                                            height: 5*Config.blockSizeHorizental,

                                            child: Center(child: Text("Order no",style:TextStyle(fontSize: 2*Config.textMultipier),))),
                                        Container(

                                          child: Center(child: Text("Item Name",style:TextStyle(fontSize: 2*Config.textMultipier),)),
                                          width: 20*Config.blockSizeHorizental,
                                          height: 5*Config.blockSizeHorizental,
                                          //color: Colors.red,
                                        ),
                                        Container(
                                            width: 10*Config.blockSizeHorizental,
                                            height: 5*Config.blockSizeHorizental,

                                            child: Center(child: Text("Qty",style:TextStyle(fontSize: 2*Config.textMultipier),))),
                                        Container(
                                            width: 12*Config.blockSizeHorizental,
                                            height: 5*Config.blockSizeHorizental,
                                            child: Center(child: Text("Price",style:TextStyle(fontSize: 2*Config.textMultipier),))),
                                        Container(
                                            width: 20*Config.blockSizeHorizental,
                                            height: 5*Config.blockSizeHorizental,
                                            child: Center(child: Text("Sub Total",style:TextStyle(fontSize: 2*Config.textMultipier),))),


                                      ],
                                    )
                                ),






                              ]),
                            ),

                            Container(
                              color: Colors.white,
                              height: 10*Config.textMultipier,
                              width:  50*Config.textMultipier,
                              child: Column(

                                children: [
                                  Container(
                                    width: 50*Config.textMultipier,
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
                                        Text("Total :",style: TextStyle(color: Colors.red,fontSize: 3*Config.textMultipier),),
                                        Text("700",style: TextStyle(color: Colors.green,fontSize: 5*Config.textMultipier),),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: 50*Config.textMultipier,
                              height:  7*Config.textMultipier,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(1*Config.textMultipier),
                                    child: RaisedButton(

                                      color: Colors.purple,
                                      child:

                                      Container(
                                          width: 10*Config.textMultipier,
                                          height:  7*Config.textMultipier,

                                          alignment: Alignment.center,
                                          child: Text("Save and Bill",style: TextStyle(color: Colors.white),)),
                                      onPressed: (){
                                        //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                      },
                                    ),
                                  ),
                                  Container(
                                    //  margin: EdgeInsets.only(top:5*Config.textMultipier),
                                    margin: EdgeInsets.all(1*Config.textMultipier),
                                    child: RaisedButton(

                                      color: Colors.deepOrangeAccent,
                                      child:

                                      Container(
                                          width: 10*Config.textMultipier,
                                          height:  7*Config.textMultipier,

                                          alignment: Alignment.center,
                                          child: Text("Save Only",style: TextStyle(color: Colors.white),)),
                                      onPressed: (){
                                        ///Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                      },
                                    ),
                                  ),
                                  Container(
                                    //margin: EdgeInsets.only(top:5*Config.textMultipier),
                                    margin: EdgeInsets.all(1*Config.textMultipier),
                                    child: RaisedButton(

                                      color: Colors.yellow[400],
                                      child:

                                      Container(
                                          width: 10*Config.textMultipier,
                                          height:  7*Config.textMultipier,

                                          alignment: Alignment.center,
                                          child: Text("Print And Save",style: TextStyle(color: Colors.white),)),
                                      onPressed: (){
                                        //  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                      },
                                    ),
                                  ),

                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                      Expanded(flex: 1,
                        child: Container(
                            height: 40*Config.textMultipier,
                            width:  60*Config.textMultipier,
                            child: DefaultTabController(
                              length: 3,
                              child: Scaffold(
                                appBar: AppBar(

                                  title: Text('Types of Payment',style:TextStyle(color: Colors.black),),
                                  backgroundColor: Colors.blue,
                                  iconTheme: IconThemeData(
                                    color: Colors.grey, //change your color here
                                  ),
                                  toolbarHeight: 10*Config.textMultipier,
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
                                            width: 10*Config.textMultipier,
                                            padding: EdgeInsets.all(8),
                                            height: 5*Config.textMultipier,
                                            child: TabBar(

                                              unselectedLabelColor: Colors.pink,
                                              indicator: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Colors.yellow[700]

                                              ),
                                              tabs: [


                                                Container(
                                                    width: 10*Config.textMultipier,

                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5)
                                                      ,
                                                      //  color: Colors.pink[100],
                                                    ),
                                                    margin: EdgeInsets.only(top: 5),
                                                    child: Tab(child: Text(
                                                      "Credit", style: TextStyle(
                                                      fontFamily: 'Noto Sans',
                                                      fontSize: 12,
                                                      color: const Color(0xff292929),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                      textAlign: TextAlign.left,
                                                    ),)),
                                                Container(
                                                    width: 10*Config.textMultipier,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5)
                                                      ,
                                                      // color: Colors.pink[100],
                                                    ),

                                                    margin: EdgeInsets.only(top: 10),
                                                    child: Tab(

                                                      child: Text(
                                                        "Cash", style: TextStyle(
                                                        fontFamily: 'Noto Sans',
                                                        fontSize: 12,
                                                        color: const Color(0xff292929),
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                        textAlign: TextAlign.left,
                                                      ),)),
                                                Container(
                                                    width: 10*Config.textMultipier,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5)
                                                      ,
                                                      // color: Colors.pink[100],
                                                    ),

                                                    margin: EdgeInsets.only(top: 10),
                                                    child: Tab(

                                                      child: Text(
                                                        "Card", style: TextStyle(
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
                                    Center(
                                      child: Container(
                                        width: 50*Config.textMultipier,
                                        height: 30*Config.textMultipier,
                                        // color: Colors.red,
                                        child:  Column(
                                          children: [
                                            Container(
                                              color: Colors.grey,
                                              margin: EdgeInsets.only(top: 3*Config.textMultipier),
                                              child: Card(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.0)),
                                                child: Container(

                                                  padding:EdgeInsets.fromLTRB(15,4,15,0),
                                                  height: 5*Config.textMultipier,
                                                  alignment: Alignment.centerLeft,
                                                  width:20*Config.textMultipier,

                                                  child: TextField(
                                                    onTap: (){

                                                    },
                                                    decoration: InputDecoration(
                                                        labelText: "Enter yourname",
                                                        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))

                                                    ),

                                                  ),

                                                ),

                                              ),
                                            ),
                                            Container(
                                              color: Colors.grey,
                                              margin: EdgeInsets.only(top: 3*Config.textMultipier),
                                              child: Card(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.0)),
                                                child: Container(

                                                  padding:EdgeInsets.fromLTRB(15,4,15,0),
                                                  height: 5*Config.textMultipier,
                                                  alignment: Alignment.centerLeft,
                                                  width:20*Config.textMultipier,

                                                  child: TextField(
                                                    onTap: (){

                                                    },
                                                    decoration: InputDecoration(
                                                        labelText: "Enter Amount",
                                                        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))

                                                    ),

                                                  ),

                                                ),

                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top:3*Config.textMultipier),
                                              child: RaisedButton(

                                                color: Colors.purple,
                                                child:

                                                Container(
                                                    width: 15*Config.textMultipier,
                                                    height:  5*Config.textMultipier,

                                                    alignment: Alignment.center,
                                                    child: Text("Pay Bills",style: TextStyle(color: Colors.white),)),
                                                onPressed: (){
                                                  //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50*Config.textMultipier,
                                      height: 50*Config.textMultipier,
                                      // color: Colors.red,
                                      child: Column(
                                        children: [

                                          Container(
                                            color: Colors.grey,
                                            margin: EdgeInsets.only(top: 3*Config.textMultipier),
                                            child: Card(
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.0)),
                                              child: Container(

                                                padding:EdgeInsets.fromLTRB(15,4,15,0),
                                                height: 5*Config.textMultipier,
                                                alignment: Alignment.centerLeft,
                                                width:20*Config.textMultipier,

                                                child: TextField(
                                                  onTap: (){

                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: "Enter Amount",
                                                      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))

                                                  ),

                                                ),

                                              ),

                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:5*Config.textMultipier),
                                            child: RaisedButton(

                                              color: Colors.purple,
                                              child:

                                              Container(
                                                  width: 15*Config.textMultipier,
                                                  height:  5*Config.textMultipier,

                                                  alignment: Alignment.center,
                                                  child: Text("Pay Bills",style: TextStyle(color: Colors.white),)),
                                              onPressed: (){
                                                //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 50*Config.textMultipier,
                                      height: 50*Config.textMultipier,
                                      // color: Colors.red,
                                      child: Column(
                                        children: [

                                          Container(
                                            color: Colors.grey,
                                            margin: EdgeInsets.only(top: 3*Config.textMultipier),
                                            child: Card(
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.0)),
                                              child: Container(

                                                padding:EdgeInsets.fromLTRB(15,4,15,0),
                                                height: 5*Config.textMultipier,
                                                alignment: Alignment.centerLeft,
                                                width:20*Config.textMultipier,

                                                child: TextField(
                                                  onTap: (){

                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: "Enter yourname",
                                                      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))

                                                  ),

                                                ),

                                              ),

                                            ),
                                          ),
                                          Container(
                                            color: Colors.grey,
                                            margin: EdgeInsets.only(top: 3*Config.textMultipier),
                                            child: Card(
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.0)),
                                              child: Container(

                                                padding:EdgeInsets.fromLTRB(15,4,15,0),
                                                height: 5*Config.textMultipier,
                                                alignment: Alignment.centerLeft,
                                                width:20*Config.textMultipier,

                                                child: TextField(
                                                  onTap: (){

                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: "Enter Amount",
                                                      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))

                                                  ),

                                                ),

                                              ),

                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:5*Config.textMultipier),
                                            child: RaisedButton(

                                              color: Colors.purple,
                                              child:

                                              Container(
                                                  width: 15*Config.textMultipier,
                                                  height:  5*Config.textMultipier,

                                                  alignment: Alignment.center,
                                                  child: Text("Pay Bills",style: TextStyle(color: Colors.white),)),
                                              onPressed: (){
                                                //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),


                              ),
                            )
                        ),

                      ),

                    ],
                  ),
                )
            ),


          );
        }
        );
      }

      );
    }
    else {
      if (widget.tableIdForAllTable != null) {
        return LayoutBuilder(builder: (context, constraints) {
            return OrientationBuilder(builder: (context, orientation) {
              Config().int(constraints, orientation);
              return Scaffold(
                appBar: AppBar(
                  title: Text("Settlement"),
                  actions: <Widget>[

                    new Container(),

                    Center(
                      child: new Text(
                        ReactiveUsername.Username,
                        textScaleFactor: 1.5,
                        style: new TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),


                  ],
                ),
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: 50 * Config.blockSizeVertical,
                      padding: EdgeInsets.all(1 * Config.textMultipier),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [

                                Container(

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
                                  child: this.subtotal==null?FutureBuilder<List<TotalBills>>(
                                      future: getTotalBills(widget.tableIdForAllTable),
                                      builder: (context, snapshot) {
                                        try {
                                          if (snapshot.hasData) {
                                            final us = snapshot.data;
                                            totalBillsforAllTable=us;


                                            return ListView.builder(
                                              controller: new ScrollController(
                                                  keepScrollOffset: false),
                                              // scrollDirection: Axis.vertical,
                                              itemCount: us == null ? 0 : us
                                                  .length,


                                              itemBuilder: (
                                                  BuildContext context,
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

                                  ):
                                  Container(
                                    height: 30 * Config.blockSizeVertical,
                                    child: ListView.builder(
                                      controller: new ScrollController(
                                          keepScrollOffset: false),
                                      // scrollDirection: Axis.vertical,
                                      itemCount: totalBillsforAllTable == null ? 0 : totalBillsforAllTable
                                          .length,


                                      itemBuilder: (
                                          BuildContext context,
                                          int index) {
                                        final all = totalBillsforAllTable[index];
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
                                  )
                                  ,

                                ),
                                Container(

                                  alignment: Alignment.centerRight,
                                  height: 15 * Config.textMultipier,
                                  width: 50 * Config.textMultipier,
                                  child:this.subtotal==null? FutureBuilder<List<TotalBills>>(
                                      future: getTotalBills(widget.tableIdForAllTable),

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
                                  ):
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
                                              totalBillsforAllTable.first
                                                  .subtTotal
                                                  .toString()),),
                                        Container(alignment: Alignment
                                            .centerRight,
                                          height: 35,
                                          width: 30 *
                                              Config.textMultipier,
                                          child: Text("Vat:" +
                                              totalBillsforAllTable.first.vat
                                                  .toString()),),
                                        Container(alignment: Alignment
                                            .centerRight,
                                          height: 35,
                                          width: 30 *
                                              Config.textMultipier,
                                          child: Text("Grand Total:" +
                                              totalBillsforAllTable.first
                                                  .grandTotal
                                                  .toString()),),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Expanded(flex: 1,
                            child: Container(
                                height: 50 * Config.textMultipier,
                                width: 50 * Config.textMultipier,
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

                                                          child: Center(child: Text("Contact Name"))),

                                                      if(searchloading==false)
                                                        Container(
                                                          height: 150,
                                                        )
                                                      else Container()


                                                    ],
                                                  ),
                                                  flex: 1, ),
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.all(10),
                                                    padding: EdgeInsets.all(
                                                        1* Config.textMultipier),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black26,
                                                        ),
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Column(
                                                      children: [

                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              // margin: EdgeInsets.all(10),

                                                              child: TextField(

                                                                  onTap: (){
                                                                    setState(() {

                                                                      searchloading=false;
                                                                      loading=false;

                                                                    });
                                                                  },

                                                                  controller: searchItemNamesController,
                                                                  maxLines: 5,
                                                                  minLines: 1,

                                                                  decoration: InputDecoration(hintText: query??"Search"
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
                                                              child:loadings==true?IconButton(
                                                                icon: Icon(Icons.arrow_drop_down),
                                                                onPressed: (){
                                                                  setState(() {
                                                                    searchloading=false;
                                                                    loadings=false;
                                                                  });

                                                                },
                                                              ):
                                                              IconButton(
                                                                icon: Icon(Icons.arrow_circle_up),
                                                                onPressed: (){
                                                                  setState(() {

                                                                    searchloading=true;
                                                                    loadings=true;
                                                                    });

                                                                },

                                                              ) ,
                                                              flex: 1,
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Container(
                                                                height: 2,
                                                                color: Colors.white,
                                                                child:loading==true? FutureBuilder<List<CreditorBill>>(
                                                                    future: getCreditorBills(),
                                                                    builder: (context, snapshot) {
                                                                      doawaitedlist=snapshot.data;
                                                                      return Text("sdsd");
                                                                    }
                                                                ):Container()),
                                                            if (searchloading==false) Container(
                                                                height: 150,
                                                                color: Colors.black26,
                                                                child:doawaitedlist!=null?ListView.builder(

                                                                    itemCount: doawaitedlist.length,
                                                                    itemBuilder: (con, ind) {


                                                                      if (searchItemNamesController.text == ""){ return ListTile(
                                                                          title: Text( doawaitedlist[ind].name),

                                                                          onTap: () {
                                                                            setState(() {
                                                                              garndTotal=true;
                                                                              loadings=true;
                                                                              creditorsBillsForOpenTable.clear();
                                                                              creditorsBillsForOpenTable.add(CreditorBill(Id: doawaitedlist[ind].Id,phone: doawaitedlist[ind].phone));
                                                                              this.phonenumber= doawaitedlist[ind].phone;

                                                                              searchloading=true;
                                                                              query =  doawaitedlist[ind].name;
                                                                              searchItemNamesController.value = searchItemNamesController.value.copyWith(
                                                                                  text:  doawaitedlist[ind].name,
                                                                                  selection: TextSelection.collapsed(offset:  doawaitedlist[ind].name.length));
                                                                            });
                                                                          });}

                                                                      return query.trim().isEmpty
                                                                          ? null
                                                                          : doawaitedlist[ind].name
                                                                          .toLowerCase()
                                                                          .contains(query.toLowerCase())
                                                                          ? ListTile(
                                                                          title: Text( doawaitedlist[ind].name),

                                                                          onTap: () {
                                                                            setState(() {
                                                                              loadings=true;
                                                                              garndTotal=true;
                                                                              creditorsBillsForOpenTable.clear();
                                                                              creditorsBillsForOpenTable.add(CreditorBill(Id: doawaitedlist[ind].Id,phone: doawaitedlist[ind].phone));
                                                                              this.phonenumber= doawaitedlist[ind].phone;

                                                                              searchloading=true;
                                                                              query =  doawaitedlist[ind].name;
                                                                              searchItemNamesController.value = searchItemNamesController.value.copyWith(
                                                                                  text:  doawaitedlist[ind].name,
                                                                                  selection: TextSelection.collapsed(offset:  doawaitedlist[ind].name.length));
                                                                            });
                                                                          })
                                                                          : Container();
                                                                    }):Container())
                                                            else Container(),


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
                                                  Expanded(child: Center(child: Text("phone Number")),flex: 1,),
                                                  Expanded(
                                                    child: Container(
                                                      alignment: Alignment.centerLeft,
                                                      height: 60,
                                                      margin: EdgeInsets.all(10),
                                                      padding: EdgeInsets.all(
                                                          1* Config.textMultipier),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),

                                                          border: Border.all(
                                                              color: Colors.black26
                                                          )
                                                      ),




                                                      child: Text(this.phonenumber??"PhoneNumber"),

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
                                                          Config.textMultipier,left: 8),
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
                                                        onPressed: ()async {
                                                          //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                          CheckOut checkOuts= await checkOut(widget.tableIdForOpenTable,widget.useridForOpenTable,this.creditorsBillsForOpenTable,"Cash");
                                                          if(checkOuts.message=="Success"){

                                                            Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
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
                                                Expanded(child: Center(child: Text("Total Amount")),flex: 1,),
                                                Expanded(
                                                  child: Container(

                                                    margin: EdgeInsets.only(top: 1 *
                                                        Config.textMultipier),

                                                    child:Container(

                                                      padding: EdgeInsets.fromLTRB(
                                                          15, 4, 15, 0),
                                                      height: 80,
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      width: 20 *
                                                          Config.textMultipier,

                                                      child: TextField(
                                                        onTap: () {

                                                        },

                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                            labelText: 'Grand Total',
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10))),

                                                      ),

                                                    ),
                                                  ),
                                                  flex: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Form(
                                            child: Row(
                                              children: [
                                                Expanded(child:Container(
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
                                                    onPressed: () async{

                                                      CheckOut checkOuts= await checkOut(widget.tableIdForAllTable,widget.useridForAllTable,creditorsBillsForOpenTable,"Cash");
                                                      if(checkOuts.message=="Success"){
                                                        Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                      }


                                                      //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                                    },
                                                  ),
                                                ),flex: 1,),
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

                                            Container(height: 50, width: 50*Config.textMultipier,
                                              child:_counter==2?FutureBuilder<List<ModeOfPayment>>(
                                                  future: getPayemntMode(_counter),
                                                  builder: (context, snapshot) {
                                                    try{

                                                      if (snapshot.hasData) {
                                                        final closeTableIndex=snapshot.data;

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
                                                          itemCount: closeTableIndex == null ? 0 : closeTableIndex.length,


                                                          itemBuilder: (BuildContext context,int index){
                                                            final closeTableDetail= closeTableIndex[index];


                                                            return  Container(
                                                              //  color: Colors.black,
                                                              width: 100,
                                                              height: 30,
                                                              child:  InkWell(
                                                                onTap: ()async{
                                                                  CheckOut checkOuts= await checkOut(widget.tableIdForAllTable,widget.useridForAllTable,creditorsBillsForOpenTable,closeTableDetail.name);
                                                                  if(checkOuts.message=="Success"){
                                                                    Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                                  }


                                                                  // Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(closeTable:closeTableDetail,id: reactiveUserID.UserId,Username: ReactiveUsername.Username,)));

                                                                },
                                                                child:Center(
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),

                                                                    child: Text(closeTableDetail.name),
                                                                  ),
                                                                ),

                                                              ),
                                                            );
                                                          },
                                                        );
                                                        ///print(us.data);
                                                        //return(Home());

                                                      }
                                                    }catch( SocketException){
                                                      print(Exception);

                                                    }

                                                    return Center(child: CircularProgressIndicator(
                                                      backgroundColor: Colors.yellow,

                                                    ));
                                                  }

                                              ):Container(

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
                    )
                ),


              );
            });
          });
      }
      if (widget.tableIdForUsernameAllTable != null) {
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            Config().int(constraints, orientation);
            return Scaffold(
              appBar: AppBar(
                title: Text("Settlement"),
                actions: <Widget>[

                  new Container(),

                  Center(
                    child: new Text(
                      "use",
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
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 50 * Config.blockSizeVertical,
                    padding: EdgeInsets.all(1 * Config.textMultipier),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [

                              Container(

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
                                child:this.subtotal==null?FutureBuilder<List<TotalBills>>(
                                    future: getTotalBills(widget.tableIdForUsernameAllTable),
                                    builder: (context, snapshot) {
                                      try {
                                        if (snapshot.hasData) {
                                          final us = snapshot.data;
                                          totalBillsforAllsTable=us;


                                          return ListView.builder(
                                            controller: new ScrollController(
                                                keepScrollOffset: false),
                                            // scrollDirection: Axis.vertical,
                                            itemCount: us == null ? 0 : us
                                                .length,


                                            itemBuilder: (
                                                BuildContext context,
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

                                ):
                                Container(
                                  height: 30 * Config.blockSizeVertical,
                                  child: ListView.builder(
                                    controller: new ScrollController(
                                        keepScrollOffset: false),
                                    // scrollDirection: Axis.vertical,
                                    itemCount: totalBillsforAllsTable == null ? 0 : totalBillsforAllsTable
                                        .length,


                                    itemBuilder: (
                                        BuildContext context,
                                        int index) {
                                      final all = totalBillsforAllsTable[index];
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
                                )
                                ,

                              ),
                              Container(

                                alignment: Alignment.centerRight,
                                height: 15 * Config.textMultipier,
                                width: 50 * Config.textMultipier,
                                child:this.subtotal==null? FutureBuilder<List<TotalBills>>(
                                    future: getTotalBills(widget.tableIdForUsernameAllTable),

                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        double sums = snapshot.data.fold(
                                            0, (a, b) {
                                          return a + b.total;
                                        });
                                        totalBillsforAllTable=snapshot.data;

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
                                ):
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
                                            totalBillsforAllTable.first
                                                .subtTotal
                                                .toString()),),
                                      Container(alignment: Alignment
                                          .centerRight,
                                        height: 35,
                                        width: 30 *
                                            Config.textMultipier,
                                        child: Text("Vat:" +
                                            totalBillsforAllTable.first.vat
                                                .toString()),),
                                      Container(alignment: Alignment
                                          .centerRight,
                                        height: 35,
                                        width: 30 *
                                            Config.textMultipier,
                                        child: Text("Grand Total:" +
                                            totalBillsforAllTable.first
                                                .grandTotal
                                                .toString()),),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Expanded(flex: 1,
                          child: Container(
                              height: 50 * Config.textMultipier,
                              width: 50 * Config.textMultipier,
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

                                                        child: Center(child: Text("Contact Name"))),

                                                    if(searchloading==false)
                                                      Container(
                                                        height: 150,
                                                      )
                                                    else Container()


                                                  ],
                                                ),
                                                flex: 1, ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  padding: EdgeInsets.all(
                                                      1* Config.textMultipier),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black26,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Column(
                                                    children: [

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            // margin: EdgeInsets.all(10),

                                                            child: TextField(

                                                                onTap: (){
                                                                  setState(() {

                                                                    searchloading=false;
                                                                    loading=false;

                                                                  });
                                                                },

                                                                controller: searchItemNamesController,
                                                                maxLines: 5,
                                                                minLines: 1,

                                                                decoration: InputDecoration(hintText: query??"Search"
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
                                                            child:loadings==true?IconButton(
                                                              icon: Icon(Icons.arrow_drop_down),
                                                              onPressed: (){
                                                                setState(() {
                                                                  searchloading=false;
                                                                  loadings=false;
                                                                });

                                                              },
                                                            ):
                                                            IconButton(
                                                              icon: Icon(Icons.arrow_circle_up),
                                                              onPressed: (){
                                                                setState(() {

                                                                  searchloading=true;
                                                                  loadings=true;
                                                            });

                                                              },

                                                            ) ,
                                                            flex: 1,
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                              height: 2,
                                                              color: Colors.white,
                                                              child:loading==true? FutureBuilder<List<CreditorBill>>(
                                                                  future: getCreditorBills(),
                                                                  builder: (context, snapshot) {
                                                                    doawaitedlist=snapshot.data;
                                                                    return Text("sdsd");
                                                                  }
                                                              ):Container()),
                                                          if (searchloading==false) Container(
                                                              height: 150,
                                                              color: Colors.black26,
                                                              child:doawaitedlist!=null?ListView.builder(

                                                                  itemCount: doawaitedlist.length,
                                                                  itemBuilder: (con, ind) {

                                                                    if (searchItemNamesController.text == ""){ return ListTile(
                                                                        title: Text( doawaitedlist[ind].name),

                                                                        onTap: () {
                                                                          setState(() {
                                                                            garndTotal=true;
                                                                            loadings=true;
                                                                            creditorsBillsForOpenTable.clear();
                                                                            creditorsBillsForOpenTable.add(CreditorBill(Id: doawaitedlist[ind].Id,phone: doawaitedlist[ind].phone));
                                                                            this.phonenumber= doawaitedlist[ind].phone;

                                                                            searchloading=true;
                                                                            query =  doawaitedlist[ind].name;
                                                                            searchItemNamesController.value = searchItemNamesController.value.copyWith(
                                                                                text:  doawaitedlist[ind].name,
                                                                                selection: TextSelection.collapsed(offset:  doawaitedlist[ind].name.length));
                                                                          });
                                                                        });}

                                                                    return query.trim().isEmpty
                                                                        ? null
                                                                        : doawaitedlist[ind].name
                                                                        .toLowerCase()
                                                                        .contains(query.toLowerCase())
                                                                        ? ListTile(
                                                                        title: Text( doawaitedlist[ind].name),

                                                                        onTap: () {
                                                                          setState(() {
                                                                            loadings=true;
                                                                            garndTotal=true;
                                                                            creditorsBillsForOpenTable.clear();
                                                                            creditorsBillsForOpenTable.add(CreditorBill(Id: doawaitedlist[ind].Id,phone: doawaitedlist[ind].phone));
                                                                            this.phonenumber= doawaitedlist[ind].phone;

                                                                            searchloading=true;
                                                                            query =  doawaitedlist[ind].name;
                                                                            searchItemNamesController.value = searchItemNamesController.value.copyWith(
                                                                                text:  doawaitedlist[ind].name,
                                                                                selection: TextSelection.collapsed(offset:  doawaitedlist[ind].name.length));
                                                                          });
                                                                        })
                                                                        : Container();
                                                                  }):Container())
                                                          else Container(),


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
                                                Expanded(child: Center(child: Text("phone Number")),flex: 1,),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.centerLeft,
                                                    height: 60,
                                                    margin: EdgeInsets.all(10),
                                                    padding: EdgeInsets.all(
                                                        1* Config.textMultipier),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),

                                                        border: Border.all(
                                                            color: Colors.black26
                                                        )
                                                    ),




                                                    child: Text(this.phonenumber??"PhoneNumber"),

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
                                                        Config.textMultipier,left: 8),
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
                                                      onPressed: ()async {
                                                        //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                        CheckOut checkOuts= await checkOut(widget.tableIdForOpenTable,widget.useridForOpenTable,this.creditorsBillsForOpenTable,"Cash");
                                                        if(checkOuts.message=="Success"){

                                                          Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
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
                                              Expanded(child: Center(child: Text("Total Amount")),flex: 1,),
                                              Expanded(
                                                child: Container(

                                                  margin: EdgeInsets.only(top: 1 *
                                                      Config.textMultipier),

                                                  child:Container(

                                                    padding: EdgeInsets.fromLTRB(
                                                        15, 4, 15, 0),
                                                    height: 80,
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    width: 20 *
                                                        Config.textMultipier,

                                                    child: TextField(
                                                      onTap: () {

                                                      },

                                                      readOnly: true,
                                                      decoration: InputDecoration(
                                                          labelText: totalBillsforAllTable.first.grandTotal.toString()??'Grand Total',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10))),

                                                    ),

                                                  ),
                                                ),
                                                flex: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Form(
                                          child: Row(
                                            children: [
                                              Expanded(child:Container(
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
                                                  onPressed: () async{

                                                    CheckOut checkOuts= await checkOut(widget.tableIdForAllTable,widget.useridForAllTable,creditorsBillsForOpenTable,"Cash");
                                                    if(checkOuts.message=="Success"){
                                                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                    }


                                                    //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                                  },
                                                ),
                                              ),flex: 1,),
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
                                          Container(height: 50, width: 50*Config.textMultipier,
                                            child:_counter==2?FutureBuilder<List<ModeOfPayment>>(
                                                future: getPayemntMode(_counter),
                                                builder: (context, snapshot) {
                                                  try{

                                                    if (snapshot.hasData) {
                                                      final closeTableIndex=snapshot.data;

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
                                                        itemCount: closeTableIndex == null ? 0 : closeTableIndex.length,


                                                        itemBuilder: (BuildContext context,int index){
                                                          final closeTableDetail= closeTableIndex[index];


                                                          return  Container(
                                                            //  color: Colors.black,
                                                            width: 100,
                                                            height: 30,
                                                            child:  InkWell(
                                                              onTap: ()async{
                                                                CheckOut checkOuts= await checkOut(widget.tableIdForAllTable,widget.useridForAllTable,creditorsBillsForOpenTable,closeTableDetail.name);
                                                                if(checkOuts.message=="Success"){
                                                                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                                }


                                                                // Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(closeTable:closeTableDetail,id: reactiveUserID.UserId,Username: ReactiveUsername.Username,)));

                                                              },
                                                              child:Center(
                                                                child: Container(
                                                                  margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),

                                                                  child: Text(closeTableDetail.name),
                                                                ),
                                                              ),

                                                            ),
                                                          );
                                                        },
                                                      );
                                                      ///print(us.data);
                                                      //return(Home());

                                                    }
                                                  }catch( SocketException){
                                                    print(Exception);

                                                  }

                                                  return Center(child: CircularProgressIndicator(
                                                    backgroundColor: Colors.yellow,

                                                  ));
                                                }

                                            ):Container(),
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
                  )
              ),


            );
          });
        });
      }

      else if (widget.tableIdForOpenTable !=null){
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            Config().int(constraints, orientation);
            return Scaffold(
              appBar: AppBar(
                title: Text("Settlement"),
                actions: <Widget>[

                  new Container(),

                  Center(
                    child: new Text(
                      ReactiveUsername.Username,
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
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 50 * Config.blockSizeVertical,
                    padding: EdgeInsets.all(1 * Config.textMultipier),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [

                              Container(

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
                                child: this.subtotal==null?FutureBuilder<List<TotalBills>>(
                                    future: getTotalBills(widget.tableIdForOpenTable),
                                    builder: (context, snapshot) {
                                      try {
                                        if (snapshot.hasData) {
                                          final us = snapshot.data;

                                          totalBillsforOpenTable=us;
                                          return ListView.builder(
                                            controller: new ScrollController(
                                                keepScrollOffset: false),
                                            // scrollDirection: Axis.vertical,
                                            itemCount: us == null ? 0 : us
                                                .length,


                                            itemBuilder: (
                                                BuildContext context,
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

                                ):
                                Container(
                                  height: 30 * Config.blockSizeVertical,


                                  child: ListView.builder(
                                    controller: new ScrollController(
                                        keepScrollOffset: false),
                                    // scrollDirection: Axis.vertical,
                                    itemCount: totalBillsforOpenTable == null ? 0 : totalBillsforOpenTable
                                        .length,


                                    itemBuilder: (
                                        BuildContext context,
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
                                child: subtotal==null?FutureBuilder<List<TotalBills>>(
                                    future: getTotalBills(widget.tableIdForOpenTable),

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
                                ):
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
                                        child: Text("Total:"+totalBillsforOpenTable.first.total.toString(),),),
                                      Container(alignment: Alignment
                                          .centerRight,
                                        height: 35,
                                        width: 30 *
                                            Config.textMultipier,
                                        child: Text("Vat"+totalBillsforOpenTable.first.vat.toString()),),
                                      Container(alignment: Alignment
                                          .centerRight,
                                        height: 35,
                                        width: 30 *
                                            Config.textMultipier,
                                        child: Text("Grand Total :"+totalBillsforOpenTable.first.grandTotal.toString()),),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Expanded(flex: 1,
                          child: Container(
                              height: 50 * Config.textMultipier,
                              width: 50 * Config.textMultipier,
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

                                                        child: Center(child: Text("Contact Name"))),

                                                    if(searchloading==false)
                                                      Container(
                      height: 150,
                  )
                                                    else Container()


                                                  ],
                                                ),
                                                flex: 1, ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  padding: EdgeInsets.all(
                                                      1* Config.textMultipier),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black26,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Column(
                                                    children: [

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                           // margin: EdgeInsets.all(10),

                                                            child: TextField(

                                                                onTap: (){
                                                                  setState(() {
                                                                      keyBoardHide=true;
                                                                    searchloading=false;
                                                                    loading=false;

                                                                  });
                                                                },

                                                                controller: searchItemNamesController,
                                                                maxLines: 5,
                                                                minLines: 1,

                                                                decoration: InputDecoration(hintText: query??"Search"
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
                                                            child:loadings==true?IconButton(
                                                              icon: Icon(Icons.arrow_drop_down),
                                                              onPressed: (){
                                                                setState(() {
                                                                  searchloading=false;
                                                                  loadings=false;
                                                                });

                                                              },
                                                            ):
                                                            IconButton(
                                                              icon: Icon(Icons.arrow_circle_up),
                                                              onPressed: (){
                                                                setState(() {

                                                                  searchloading=true;
                                                                  loadings=true;
                                                                });

                                                              },

                                                            ) ,
                                                            flex: 1,
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                              height: 2,
                                                              color: Colors.white,
                                                              child:loading==true? FutureBuilder<List<CreditorBill>>(
                                                                  future: getCreditorBills(),
                                                                  builder: (context, snapshot) {
                                                                    doawaitedlist=snapshot.data;
                                                                    return Text("sdsd");
                                                                  }
                                                              ):Container()),
                                                          if (searchloading==false) Container(
                                                              height: 150,
                                                              color: Colors.black26,
                                                              child:doawaitedlist!=null?ListView.builder(

                                                                  itemCount: doawaitedlist.length,
                                                                  itemBuilder: (con, ind) {


                                                                    if (searchItemNamesController.text == ""){ return ListTile(
                                                                        title: Text( doawaitedlist[ind].name),

                                                                        onTap: () {
                                                                          setState(() {
                                                                            garndTotal=true;
                                                                            loadings=true;
                                                                            creditorsBillsForOpenTable.clear();
                                                                            creditorsBillsForOpenTable.add(CreditorBill(Id: doawaitedlist[ind].Id,phone: doawaitedlist[ind].phone));
                                                                            this.phonenumber= doawaitedlist[ind].phone;

                                                                            searchloading=true;
                                                                            query =  doawaitedlist[ind].name;
                                                                            searchItemNamesController.value = searchItemNamesController.value.copyWith(
                                                                                text:  doawaitedlist[ind].name,
                                                                                selection: TextSelection.collapsed(offset:  doawaitedlist[ind].name.length));
                                                                          });
                                                                        });}

                                                                    return query.trim().isEmpty
                                                                        ? null
                                                                        : doawaitedlist[ind].name
                                                                        .toLowerCase()
                                                                        .contains(query.toLowerCase())
                                                                        ? ListTile(
                                                                        title: Text( doawaitedlist[ind].name),

                                                                        onTap: () {
                                                                          setState(() {
                                                                            loadings=true;
                                                                            garndTotal=true;
                                                                                              creditorsBillsForOpenTable.clear();
                                                                                              creditorsBillsForOpenTable.add(CreditorBill(Id: doawaitedlist[ind].Id,phone: doawaitedlist[ind].phone));
                                                                                              this.phonenumber= doawaitedlist[ind].phone;

                                                                            searchloading=true;
                                                                            query =  doawaitedlist[ind].name;
                                                                            searchItemNamesController.value = searchItemNamesController.value.copyWith(
                                                                                text:  doawaitedlist[ind].name,
                                                                                selection: TextSelection.collapsed(offset:  doawaitedlist[ind].name.length));
                                                                          });
                                                                        })
                                                                        : Container();
                                                                  }):Container())
                                                          else Container(),


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
                                                Expanded(child: Center(child: Text("phone Number")),flex: 1,),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.centerLeft,
                                                    height: 60,
                                                    margin: EdgeInsets.all(10),
                                                    padding: EdgeInsets.all(
                                                        1* Config.textMultipier),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),

                                                        border: Border.all(
                                                            color: Colors.black26
                                                        )
                                                    ),




                                                    child: Text(this.phonenumber??"PhoneNumber"),

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
                                                        Config.textMultipier,left: 8),
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
                                                      onPressed: ()async {
                                                        //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                        CheckOut checkOuts= await checkOut(widget.tableIdForOpenTable,widget.useridForOpenTable,this.creditorsBillsForOpenTable,"Cash");
                                                        if(checkOuts.message=="Success"){

                                                          Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
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
                                    Container(
                                      width: 50 * Config.textMultipier,
                                      height: 50 * Config.textMultipier,
                                      // color: Colors.red,
                                      child: Column(

                                        children: [
                                          Form(
                                            child: Row(
                                              children: [
                                                Expanded(child: Center(child: Text("Total Amount")),flex: 1,),
                                                Expanded(
                                                  child: Container(

                                                    margin: EdgeInsets.only(top: 1 *
                                                        Config.textMultipier),

                                                    child:Container(

                                                      padding: EdgeInsets.fromLTRB(
                                                          15, 4, 15, 0),
                                                      height: 80,
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      width: 20 *
                                                          Config.textMultipier,

                                                      child: TextField(
                                                        onTap: () {

                                                        },

                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                            labelText: totalBillsforOpenTable.first.grandTotal.toString()??'Grand Total',
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10))),

                                                      ),

                                                    ),
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
                                                        Config.textMultipier,left: 8),
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
                                                      onPressed: () async{
                                                        setState(() {

                                                        });


                                                        CheckOut checkOuts= await checkOut(widget.tableIdForOpenTable,widget.useridForOpenTable,this.creditorsBillsForOpenTable,"Cash");
                                                        if(checkOuts.message=="Success"){

                                                          Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
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

                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 50 * Config.textMultipier,
                                      height: 50,
                                      // color: Colors.red,
                                      child: Column(
                                        children: [
                                          Container(height: 50, width: 50*Config.textMultipier,
                                            child:_counter==2 ?FutureBuilder<List<ModeOfPayment>>(
                                                future: getPayemntMode(_counter),
                                                builder: (context, snapshot) {
                                                  try{

                                                    if (snapshot.hasData) {
                                                      final closeTableIndex=snapshot.data;

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
                                                        itemCount: closeTableIndex == null ? 0 : closeTableIndex.length,


                                                        itemBuilder: (BuildContext context,int index){
                                                          final closeTableDetail= closeTableIndex[index];


                                                          return  Container(
                                                            //  color: Colors.black,
                                                            width: 100,
                                                            height: 30,
                                                            child:  InkWell(
                                                              onTap: ()async{
                                                                CheckOut checkOuts= await checkOut(widget.tableIdForOpenTable,widget.useridForOpenTable,this.creditorsBillsForOpenTable,closeTableDetail.name);
                                                                if(checkOuts.message=="Success"){

                                                                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                                }

                                                                // Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(closeTable:closeTableDetail,id: reactiveUserID.UserId,Username: ReactiveUsername.Username,)));

                                                              },
                                                              child:Center(
                                                                child: Container(
                                                                  margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),

                                                                  child: Text(closeTableDetail.name),
                                                                ),
                                                              ),

                                                            ),
                                                          );
                                                        },
                                                      );
                                                      ///print(us.data);
                                                      //return(Home());

                                                    }
                                                  }catch( SocketException){
                                                    print(Exception);

                                                  }

                                                  return Center(child: CircularProgressIndicator(
                                                    backgroundColor: Colors.yellow,

                                                  ));
                                                }

                                            ):
                                            Container(
                                              height: 50, width: 50*Config.textMultipier,
                                              child: ListView.builder(
                                                controller: new ScrollController(
                                                    keepScrollOffset: false),
                                                scrollDirection: Axis.horizontal,

                                                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                //   crossAxisCount: 4,
                                                //   mainAxisSpacing: 5.0,
                                                //   crossAxisSpacing: 5.0,
                                                //
                                                // ),
                                                itemCount: paymenylistMethod == null ? 0 : paymenylistMethod.length,


                                                itemBuilder: (BuildContext context,int index){
                                                  final closeTableDetail= paymenylistMethod[index];


                                                  return  Container(
                                                    //  color: Colors.black,
                                                    width: 100,
                                                    height: 30,
                                                    child:  InkWell(
                                                      onTap: (){
                                                        setState(() {

                                                          //  tableId=closeTableDetail.id;


                                                        });

                                                        // Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(closeTable:closeTableDetail,id: reactiveUserID.UserId,Username: ReactiveUsername.Username,)));

                                                      },
                                                      child:Center(
                                                        child: Container(
                                                          margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),

                                                          child: Text(closeTableDetail.name),
                                                        ),
                                                      ),

                                                    ),
                                                  );
                                                },
                                              ),
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
                  )
              ),


            );
          });
        });
      }

      else{
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            Config().int(constraints, orientation);
            return Scaffold(
              appBar: AppBar(
                title: Text("Settlement"),
                actions: <Widget>[

                  new Container(),

                  Center(
                    child: new Text(
                      ReactiveUsername.Username,
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
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 50 * Config.blockSizeVertical,
                    padding: EdgeInsets.all(1 * Config.textMultipier),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [

                              Container(

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
                                child: this.subtotal==null?FutureBuilder<List<TotalBills>>(
                                    future: getTotalBills(widget.tableIdForCloseTable),
                                    builder: (context, snapshot) {
                                      try {
                                        if (snapshot.hasData) {
                                          final us = snapshot.data;
                                          totalBillsforCloseTable=us;


                                          return ListView.builder(
                                            controller: new ScrollController(
                                                keepScrollOffset: false),
                                            // scrollDirection: Axis.vertical,
                                            itemCount: us == null ? 0 : us
                                                .length,


                                            itemBuilder: (
                                                BuildContext context,
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

                                ):
                                Container(
                                  height: 30 * Config.blockSizeVertical,
                                  child: ListView.builder(
                                    controller: new ScrollController(
                                        keepScrollOffset: false),
                                    // scrollDirection: Axis.vertical,
                                    itemCount: totalBillsforCloseTable == null ? 0 : totalBillsforCloseTable
                                        .length,


                                    itemBuilder: (
                                        BuildContext context,
                                        int index) {
                                      final all = totalBillsforCloseTable[index];
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
                                )
                                ,

                              ),
                              Container(

                                alignment: Alignment.centerRight,
                                height: 15 * Config.textMultipier,
                                width: 50 * Config.textMultipier,
                                child:this.subtotal==null? FutureBuilder<List<TotalBills>>(
                                    future: getTotalBills(widget.tableIdForCloseTable),

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
                                ):
                                Container(
                                  height: 200,
                                  width: 40 *
                                      Config.blockSizeVertical,
                                  child: Column(
                                    children: [
                                      Container(alignment: Alignment
                                          .centerRight,
                                        height: 80,
                                        width: 30 *
                                            Config.textMultipier,
                                        child: Text("Total:" +
                                            totalBillsforCloseTable.first
                                                .subtTotal
                                                .toString()),),
                                      Container(alignment: Alignment
                                          .centerRight,
                                        height: 35,
                                        width: 30 *
                                            Config.textMultipier,
                                        child: Text("Vat:" +
                                            totalBillsforCloseTable.first.vat
                                                .toString()),),
                                      Container(alignment: Alignment
                                          .centerRight,
                                        height: 35,
                                        width: 30 *
                                            Config.textMultipier,
                                        child: Text("Grand Total:" +
                                            totalBillsforCloseTable.first
                                                .grandTotal
                                                .toString()),),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Expanded(flex: 1,
                          child: Container(
                              height: 50 * Config.textMultipier,
                              width: 50 * Config.textMultipier,
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

                                                        child: Center(child: Text("Contact Name"))),

                                                    if(searchloading==false)
                                                      Container(
                                                        height: 150,
                                                      )
                                                    else Container()


                                                  ],
                                                ),
                                                flex: 1, ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  padding: EdgeInsets.all(
                                                      1* Config.textMultipier),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black26,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Column(
                                                    children: [

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            // margin: EdgeInsets.all(10),

                                                            child: TextField(

                                                                onTap: (){
                                                                  setState(() {

                                                                    searchloading=false;
                                                                    loading=false;

                                                                  });
                                                                },

                                                                controller: searchItemNamesController,
                                                                maxLines: 5,
                                                                minLines: 1,

                                                                decoration: InputDecoration(hintText: query??"Search"
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
                                                            child:loadings==true?IconButton(
                                                              icon: Icon(Icons.arrow_drop_down),
                                                              onPressed: (){
                                                                setState(() {
                                                                  searchloading=false;
                                                                  loadings=false;
                                                                });

                                                              },
                                                            ):
                                                            IconButton(
                                                              icon: Icon(Icons.arrow_circle_up),
                                                              onPressed: (){
                                                                setState(() {

                                                                  searchloading=true;
                                                                  loadings=true;
                                                            });

                                                              },

                                                            ) ,
                                                            flex: 1,
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                              height: 2,
                                                              color: Colors.white,
                                                              child:loading==true? FutureBuilder<List<CreditorBill>>(
                                                                  future: getCreditorBills(),
                                                                  builder: (context, snapshot) {
                                                                    doawaitedlist=snapshot.data;
                                                                    return Text("sdsd");
                                                                  }
                                                              ):Container()),
                                                          if (searchloading==false) Container(
                                                              height: 150,
                                                              color: Colors.black26,
                                                              child:doawaitedlist!=null?ListView.builder(

                                                                  itemCount: doawaitedlist.length,
                                                                  itemBuilder: (con, ind) {


                                                                    if (searchItemNamesController.text == ""){ return ListTile(
                                                                        title: Text( doawaitedlist[ind].name),

                                                                        onTap: () {
                                                                          setState(() {
                                                                            garndTotal=true;
                                                                            loadings=true;
                                                                            creditorsBillsForOpenTable.clear();
                                                                            creditorsBillsForOpenTable.add(CreditorBill(Id: doawaitedlist[ind].Id,phone: doawaitedlist[ind].phone));
                                                                            this.phonenumber= doawaitedlist[ind].phone;

                                                                            searchloading=true;
                                                                            query =  doawaitedlist[ind].name;
                                                                            searchItemNamesController.value = searchItemNamesController.value.copyWith(
                                                                                text:  doawaitedlist[ind].name,
                                                                                selection: TextSelection.collapsed(offset:  doawaitedlist[ind].name.length));
                                                                          });
                                                                        });}

                                                                    return query.trim().isEmpty
                                                                        ? null
                                                                        : doawaitedlist[ind].name
                                                                        .toLowerCase()
                                                                        .contains(query.toLowerCase())
                                                                        ? ListTile(
                                                                        title: Text( doawaitedlist[ind].name),

                                                                        onTap: () {
                                                                          setState(() {
                                                                            loadings=true;
                                                                            garndTotal=true;
                                                                            creditorsBillsForOpenTable.clear();
                                                                            creditorsBillsForOpenTable.add(CreditorBill(Id: doawaitedlist[ind].Id,phone: doawaitedlist[ind].phone));
                                                                            this.phonenumber= doawaitedlist[ind].phone;

                                                                            searchloading=true;
                                                                            query =  doawaitedlist[ind].name;
                                                                            searchItemNamesController.value = searchItemNamesController.value.copyWith(
                                                                                text:  doawaitedlist[ind].name,
                                                                                selection: TextSelection.collapsed(offset:  doawaitedlist[ind].name.length));
                                                                          });
                                                                        })
                                                                        : Container();
                                                                  }):Container())
                                                          else Container(),


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
                                                Expanded(child: Center(child: Text("phone Number")),flex: 1,),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.centerLeft,
                                                    height: 60,
                                                    margin: EdgeInsets.all(10),
                                                    padding: EdgeInsets.all(
                                                        1* Config.textMultipier),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),

                                                        border: Border.all(
                                                            color: Colors.black26
                                                        )
                                                    ),




                                                    child: Text(this.phonenumber??"PhoneNumber"),

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
                                                        Config.textMultipier,left: 8),
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
                                                      onPressed: ()async {
                                                        //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                        CheckOut checkOuts= await checkOut(widget.tableIdForOpenTable,widget.useridForOpenTable,this.creditorsBillsForOpenTable,"Cash");
                                                        if(checkOuts.message=="Success"){

                                                          Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
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
                                              Expanded(child: Center(child: Text("Total Amount")),flex: 1,),
                                              Expanded(
                                                child: Container(

                                                  margin: EdgeInsets.only(top: 1 *
                                                      Config.textMultipier),

                                                  child:Container(

                                                    padding: EdgeInsets.fromLTRB(
                                                        15, 4, 15, 0),
                                                    height: 80,
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    width: 20 *
                                                        Config.textMultipier,

                                                    child: TextField(
                                                      onTap: () {

                                                      },

                                                      readOnly: true,
                                                      decoration: InputDecoration(
                                                          labelText: 'Grand Total',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10))),

                                                    ),

                                                  ),
                                                ),
                                                flex: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Form(
                                          child: Row(
                                            children: [
                                              Expanded(child:Container(
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
                                                  onPressed: () async{
                                                    CheckOut checkOuts= await checkOut(widget.tableIdForCloseTable,widget.useridForCloseTable,creditorsBillsForOpenTable,"Cash");
                                                    if(checkOuts.message=="Success"){
                                                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
                                                    }


                                                    //Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));

                                                  },
                                                ),
                                              ),flex: 1,),
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
                                          Container(height: 50, width: 50*Config.textMultipier,
                                            child:_counter==2?FutureBuilder<List<ModeOfPayment>>(
                                                future: getPayemntMode(_counter),
                                                builder: (context, snapshot) {
                                                  try{

                                                    if (snapshot.hasData) {
                                                      final closeTableIndex=snapshot.data;

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
                                                        itemCount: closeTableIndex == null ? 0 : closeTableIndex.length,


                                                        itemBuilder: (BuildContext context,int index){
                                                          final closeTableDetail= closeTableIndex[index];


                                                          return  Container(
                                                            //  color: Colors.black,
                                                            width: 100,
                                                            height: 30,
                                                            child:  InkWell(
                                                              onTap: ()async{
            CheckOut checkOuts= await checkOut(widget.tableIdForCloseTable,widget.useridForCloseTable,creditorsBillsForOpenTable,closeTableDetail.name);
            if(checkOuts.message=="Success"){
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home())));
            }


            // Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(closeTable:closeTableDetail,id: reactiveUserID.UserId,Username: ReactiveUsername.Username,)));

                                                              },
                                                              child:Center(
                                                                child: Container(
                                                                  margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),

                                                                  child: Text(closeTableDetail.name),
                                                                ),
                                                              ),

                                                            ),
                                                          );
                                                        },
                                                      );
                                                      ///print(us.data);
                                                      //return(Home());

                                                    }
                                                  }catch( SocketException){
                                                    print(Exception);

                                                  }

                                                  return Center(child: CircularProgressIndicator(
                                                    backgroundColor: Colors.yellow,

                                                  ));
                                                }

                                            ):Container(),
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
                  )
              ),


            );
          });
        });
      }
    }
  }
}





