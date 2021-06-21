import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant/ReactiveData/reactiveUserId.dart';
import 'package:restaurant/ReactiveData/reactive_userName.dart';
import 'package:restaurant/Services/GetAllServices.dart';
import 'package:restaurant/Services/GetBillByIdServices.dart';
import 'package:restaurant/modal/GetAllModal.dart';
import 'package:restaurant/modal/GetBillById.dart';

import 'package:restaurant/ui/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';
import 'A.dart';
import 'Login.dart';
import 'Settlement.dart';

class All extends StatefulWidget{
  final int userId;

  final String Username;
  const All({Key key, this.userId,this.Username}) : super(key: key);
  @override
  _OpensState createState() => _OpensState();
}

class _OpensState extends State<All> {

  double sum;
  double sumOfTOtal=0;
int tableId;
  bool viewVisible = false ;
  bool viewLayout = false ;
  bool halfDesign = true ;
  String tableName;
  sowe(){

  }
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

  Future<List<GetAllTableData>> getAllTabbles() async{
    try{

     return await  GetAllServices().getall();
    }catch(SocketExcpetion){
      print(SocketExcpetion);
    }
  }
  Future<List<Bills>> getBillByID(int tableId) async{
    try{

      return await  GetBillByIdServices().getall(tableId);
    }catch(SocketExcpetion){
      print(SocketExcpetion);
    }
  }
 List<GetAllTableData> allTableList=[];
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
                title: Text("ALL"),
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
                      child:   Container(

                        height: 35*Config.blockSizeHorizental,
                        child: FutureBuilder<List<GetAllTableData>>(
                            future: getAllTabbles(),
                            builder: (context, snapshot) {
                              try{

                                print(snapshot.hasData);
                                if (snapshot.hasData) {
                                  final us=snapshot.data;


                                  return GridView.builder(
                                    controller: new ScrollController(keepScrollOffset: false),
                                    semanticChildCount: 2,
                                    scrollDirection: Axis.vertical,
                                    itemCount: us == null ? 0 : us.length,


                                    itemBuilder: (BuildContext context,int index){
                                      final all= us[index];

                                      return  Container(
                                        //  color: Colors.black,
                                        width: 20*Config.blockSizeVertical,
                                        height: 35*Config.blockSizeHorizental,
                                        child:  InkWell(
                                          onTap: (){
                                            // showWidget();
                                            Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));
                                          },
                                          child:Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.blueAccent)
                                            ),

                                            width: 15*Config.blockSizeVertical,
                                            height: 25*Config.blockSizeHorizental,
                                            margin: EdgeInsets.only(left: .2*Config.textMultipier,top: .5*Config.textMultipier),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,
                                                  margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                                                  //child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

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
                              }catch( SocketException){
                                print(Exception);

                              }

                              return Center(child: CircularProgressIndicator());
                            }

                        ),
                      ),flex: 1,
                    ),
                    Expanded(
                      child:   Visibility(
                        //   maintainSize: true,
                        //    maintainAnimation: true,
                        //    maintainState: true,
                          visible: viewVisible,
                          child: Container(
                              height: 90*Config.blockSizeHorizental,
                              width: 90*Config.blockSizeHorizental,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                ),
                                color: Colors.white,
                              ),
                              //  margin: EdgeInsets.only(top: 50, bottom: 30),
                              child:  Column(
                                children: [
                                  Container(
                                    height: 90*Config.blockSizeHorizental,
                                    width: 90*Config.blockSizeHorizental,
                                    child: Column(children: <Widget>[
                                      Container(
                                        margin:EdgeInsets.all(1*Config.blockSizeHorizental),
                                        child: Row(
                                          children: [
                                            Expanded(child: Text("Server:Esan")),
                                            Expanded(child: Text("Table:D3")),
                                            Expanded(child: Text("Guest:D3")),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: .1*Config.textMultipier,
                                        child: Container(
                                          color: Colors.black,

                                        ),
                                      ),

                                      Container(
                                        // color: Colors.blue,
                                        height: 70*Config.blockSizeHorizental,
                                        width: 90*Config.blockSizeHorizental,
                                        child: Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                child:Row(
                                                  children: [
                                                    Container(

                                                      child: Text("Order N0"),
                                                      width: 7*Config.textMultipier,
                                                    ),
                                                    Container(

                                                      child: Text("Item Name"),
                                                      width: 7*Config.textMultipier,
                                                    ),
                                                    Container(
                                                        width: 5*Config.textMultipier,

                                                        child: Text("Qty")),
                                                    Container(
                                                        width: 7*Config.textMultipier,
                                                        child: Text("Price")),
                                                    Container(
                                                        width: 7*Config.textMultipier,
                                                        child: Text("Sub Total")),
                                                    Container(
                                                      width: 7*Config.textMultipier,
                                                      //child: Icon(Icons.delete_forever,color: Colors.red,)
                                                    ),

                                                  ],
                                                )
                                            ),
                                            Container(
                                              color: Colors.grey,
                                              margin: EdgeInsets.all(10),
                                              child:Row(
                                                children: [
                                                  Container(

                                                    child: Text("Order N0"),
                                                    width: 7*Config.textMultipier,
                                                  ),
                                                  Container(

                                                    child: Text("Item Name"),
                                                    width: 7*Config.textMultipier,
                                                  ),
                                                  Container(
                                                      width: 5*Config.textMultipier,

                                                      child: Text("Qty")),
                                                  Container(
                                                      width: 7*Config.textMultipier,
                                                      child: Text("Price")),
                                                  Container(
                                                      width: 7*Config.textMultipier,
                                                      child: Text("Sub Total")),
                                                  Container(
                                                      width: 7*Config.textMultipier,
                                                      child: Icon(Icons.delete_forever,color: Colors.red,)),

                                                ],

                                              ),

                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: .1*Config.textMultipier,
                                        child: Container(
                                          color: Colors.black,

                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top:1*Config.textMultipier,left:5*Config.textMultipier ),

                                            alignment: Alignment.bottomLeft,
                                            child: FloatingActionButton(
                                                heroTag: "btn2",

                                                onPressed: (){
                                                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Settle())));
                                                },
                                                elevation: 0,
                                                child: SvgPicture.asset("assets/cc.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,)

                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:1*Config.textMultipier,left:5*Config.textMultipier ),
                                            alignment: Alignment.bottomRight,
                                            child: FloatingActionButton(
                                                onPressed: (){
                                                  // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Menu())));
                                                },
                                                elevation: 0,
                                                child: SvgPicture.asset("assets/ee.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,)

                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:1*Config.textMultipier,left:5*Config.textMultipier ),
                                            alignment: Alignment.bottomRight,
                                            child: FloatingActionButton(
                                                heroTag: "btn1",
                                                onPressed: (){
                                                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Menu())));
                                                },
                                                elevation: 0,
                                                child: SvgPicture.asset("assets/ss.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

                                            ),
                                          ),

                                        ],
                                      ),



                                    ]),
                                  ),

                                ],
                              )
                          )
                      )
                      ,flex: 1,
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
          if(viewLayout==true){
            return Scaffold(
                appBar: AppBar(
                  title: Text("All Table"),
                  elevation: 0,
                  actions: <Widget>[

                    new Container(),

                    Center(
                      child: new Text(
                        ReactiveUsername.Username??"gh",
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
                            child: InkWell(child: Text("Logout"),
                              onTap: ()async{

                                var pres =await SharedPreferences.getInstance();

                                pres.remove('token');


                                Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Login())));
                              },
                            ),

                          );
                        });
                      },
                    ),
                  ],
                ),
                body:Container(
               //   margin: EdgeInsets.all(3*Config.blockSizeHorizental),
                  child:   Row(
                    children: [

                      Expanded(
                        child:    Container(
                          //width: 15*Config.blockSizeVertical,
                          height: 50*Config.blockSizeVertical,
                          child: halfDesign==true?FutureBuilder<List<GetAllTableData>>(
                              future: getAllTabbles(),
                              builder: (context, snapshot) {
                                try{

                                  if (snapshot.hasData) {
                                    final us=snapshot.data;
                                    allTableList=us;
                                    return GridView.builder(
                                    //  controller: new ScrollController(keepScrollOffset: false),
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.all(10),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 5.0,
                                        crossAxisSpacing: 5.0,

                                      ),

                                      itemCount: us == null ? 0 : us.length,


                                      itemBuilder: (BuildContext context,int index){
                                        final all= us[index];

                                        return  Container(
                                          //  color: Colors.black,
                                          width: 15*Config.blockSizeVertical,
                                          height: 25*Config.blockSizeHorizental,
                                          child:  InkWell(
                                            onTap: (){
                                              // showWidget();
                                              if(all.isOpen==true){
                                                viewLayout=true;
                                                halfDesign=false;
                                                showWidget();
                                                //this.sumOfTOtal=this.sum;

                                              }else{
                                                //maybe yo call hune bela samma build process complete vako hudaina so, teslaile yo error airako hola

                                                Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(tableData:all,userIdForAlltable: widget.userId,UsernameForAlltable: widget.Username,)));
                                              }

                                              setState(() {
                                                this.tableId=all.id;
                                                this.tableName=all.name;
                                              });


                                            },
                                            child:Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.blueAccent)
                                              ),

                                              width: 15*Config.blockSizeVertical,
                                              height: 25*Config.blockSizeHorizental,
                                              margin: EdgeInsets.only(left: .2*Config.textMultipier,top: .5*Config.textMultipier),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height:5*Config.blockSizeHorizental,
                                                    width: 5*Config.imageSizeMultipier,
                                                    child: Visibility(

                                                      child: Container(
                                                          margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                                                          child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

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
                                                        child: SvgPicture.asset("assets/u.svg",height: 14*Config.imageSizeMultipier,width: 13*Config.imageSizeMultipier,alignment: Alignment.bottomCenter,color: Colors.purple,)

                                                    ),

                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),
                                                    color: Colors.blue,
                                                    child: Text(all.name??"ada"),
                                                  )


                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );


                                  }
                                }catch( SocketException){
                                  print(Exception);

                                }

                                return Center(child: CircularProgressIndicator());
                              }

                          ):
                          Container(  height: 50*Config.blockSizeVertical,child: GridView.builder(
                            //  controller: new ScrollController(keepScrollOffset: false),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.all(10),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,

                            ),

                            itemCount: allTableList == null ? 0 : allTableList.length,


                            itemBuilder: (BuildContext context,int index){
                              final all= allTableList[index];

                              return  Container(
                                //  color: Colors.black,
                                width: 15*Config.blockSizeVertical,
                                height: 25*Config.blockSizeHorizental,
                                child:  InkWell(
                                  onTap: (){
                                    // showWidget();
                                    if(all.isOpen==true){


                                      showWidget();
                                      //this.sumOfTOtal=this.sum;

                                    }else{
                                      //maybe yo call hune bela samma build process complete vako hudaina so, teslaile yo error airako hola

                                      Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(tableData:all,userIdForAlltable: widget.userId,UsernameForAlltable: widget.Username,)));
                                    }

                                    setState(() {
                                      this.tableId=all.id;
                                      this.tableName=all.name;
                                    });


                                  },
                                  child:Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blueAccent)
                                    ),

                                    width: 15*Config.blockSizeVertical,
                                    height: 25*Config.blockSizeHorizental,
                                    margin: EdgeInsets.only(left: .2*Config.textMultipier,top: .5*Config.textMultipier),
                                    child: Column(
                                      children: [
                                        Container(
                                          height:5*Config.blockSizeHorizental,
                                          width: 5*Config.imageSizeMultipier,
                                          child: Visibility(

                                            child: Container(
                                                margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                                                child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

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
                                              child: SvgPicture.asset("assets/u.svg",height: 14*Config.imageSizeMultipier,width: 13*Config.imageSizeMultipier,alignment: Alignment.bottomCenter,color: Colors.purple,)

                                          ),

                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),
                                          color: Colors.blue,
                                          child: Text(all.name??"ada"),
                                        )


                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),),
                        ),
                      ),
                      Expanded(
                        child:   SingleChildScrollView(
                          child: Visibility(
                            //   maintainSize: true,
                            //    maintainAnimation: true,
                            //    maintainState: true,
                            visible: viewVisible,
                            child: Container(
                                height: 86*Config.blockSizeHorizental,
                                width: 30*Config.blockSizeVertical,

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.green
                                    )
                                ),
                                //  margin: EdgeInsets.only(top: 50, bottom: 30),
                                child:  Column(
                                  children: [
                                    Container(
                                      margin:EdgeInsets.all(1*Config.blockSizeHorizental),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text(ReactiveUsername.Username??"gv")),
                                          Expanded(child: Text("Name:"+this.tableName.toString()??"l,l")),
                                          Expanded(child: Text("Guest:D3")),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: .1*Config.textMultipier,
                                      child: Container(
                                        color: Colors.black,

                                      ),
                                    ),
                                    Container(
                                      height: 40*Config.blockSizeVertical,
                                      width:70*Config.blockSizeHorizental,
                                      child: Column(children: <Widget>[
                                        Container(
                                            width:70*Config.blockSizeHorizental,
                                            height: 15,
                                            margin: EdgeInsets.all(
                                                1 * Config.blockSizeHorizental),
                                            child: Row(
                                              children: [
                                                Expanded(

                                                  child: Container(

                                                    child: Text("Order No"),
                                                   // width: 14 * Config.textMultipier,
                                                  ),
                                                  flex: 3,

                                                ),
                                                Expanded(
                                                  child: Container(

                                                    child: Text("Item Name"),

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
                                                      //  width: 7 * Config.textMultipier,
                                                        child: Text("Sub Total")),
                                                  ),
                                                  flex: 2,
                                                ),


                                              ],
                                            )
                                        ),
                                        Container(
                                          height:  35*Config.blockSizeVertical,
                                          width:70*Config.blockSizeHorizental,
                                          child: FutureBuilder<List<Bills>>(
                                              future: getBillByID(this.tableId),
                                              builder: (context, snapshot) {
                                                try{


                                                  if (snapshot.hasData) {
                                                    final us=snapshot.data;

                                                    return ListView.builder(
                                                      controller: new ScrollController(keepScrollOffset: false),
                                                      // scrollDirection: Axis.vertical,
                                                      itemCount: us == null ? 0 : us.length,


                                                      itemBuilder: (BuildContext context,int index){
                                                        final all= us[index];

                                                        if (all.qty == null) {
                                                        }
                                                        else {

                                                          sum =us.fold(0??0, (a, b){


                                                            return a+b.qty*b.total;

                                                          });
                                                          // sum=total??'0';



                                                        }
                                                        return
                                                          Container(
                                                              height: 5*Config.blockSizeHorizental,
                                                              width: 30*Config.blockSizeHorizental,
                                                              color: Colors.grey,
                                                              //margin: EdgeInsets.all(10),
                                                              // margin: EdgeInsets.only(left: .1*Config.blockSizeHorizental),
                                                              child:Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Container(
                                                                      alignment:Alignment.centerLeft,
                                                                      child: Text(all.order??"mmm"),

                                                                    //  width: 10*Config.textMultipier,
                                                                    ),
                                                                    flex:3 ,
                                                                  ),
                                                                  Expanded(
                                                                    child: Container(
                                                                      alignment:Alignment.centerLeft,
                                                                      child: Text(all.item??"nn"),
                                                                     // width: 10*Config.textMultipier,
                                                                    ),
                                                                    flex: 3,
                                                                  ),
                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Container(


                                                                          child: Text(all.qty.toString())),
                                                                    ),flex: 2,
                                                                  ),
                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Container(
                                                                         // width: 7*Config.textMultipier,
                                                                          child: Text(all.total.toString())),
                                                                    ),
                                                                    flex: 2, ),





                                                                ],
                                                              )
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

                                          ),
                                        ),




                                      ]),
                                    ),
                                    Container(
                                      height: 5*Config.textMultipier,
                                      width: 45*Config.blockSizeVertical,
                                      child: FutureBuilder<List<Bills>>(
                                        future:  getBillByID(this.tableId),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData){
                                            sumOfTOtal =
                                                snapshot.data.fold(0, (a, b) {
                                                  return a + b.total;
                                                });
                                          return Container(
                                            alignment: Alignment.centerRight,
                                            height: 5 * Config.textMultipier,
                                            width: 30*Config.blockSizeVertical,
                                            child: Text("Total:" +
                                                sumOfTOtal.toString()),);
                                        }else{
                                            return  Container();
                                          }
          }
                                      ),
                                    ),
                                    SizedBox(
                                      height: .1*Config.textMultipier,
                                      child: Container(
                                        color: Colors.black,

                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top:1*Config.textMultipier,left:5*Config.textMultipier ),

                                          alignment: Alignment.bottomLeft,
                                          child: FloatingActionButton(
                                              heroTag: "btn2",

                                              onPressed: (){
                                                Navigator.push(context, new MaterialPageRoute(builder: (context)=>(A(tableIdForAllTable: tableId,useridForAllTable: reactiveUserID.UserId,))));
                                              },
                                              elevation: 0,
                                              child: SvgPicture.asset("assets/cc.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,)

                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top:1*Config.textMultipier,left:5*Config.textMultipier ),
                                          alignment: Alignment.bottomRight,
                                          child: FloatingActionButton(
                                              onPressed: (){
                                                // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Menu())));
                                              },
                                              elevation: 0,
                                              child: SvgPicture.asset("assets/ee.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,)

                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top:1*Config.textMultipier,left:5*Config.textMultipier ),
                                          alignment: Alignment.bottomRight,
                                          child: FloatingActionButton(
                                              heroTag: "btn1",
                                              onPressed: (){
                                                Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Menu( previousClosedTableAmount:sumOfTOtal,userIdForAlltable:reactiveUserID.UserId ,UsernameForAlltable:ReactiveUsername.Username,tableIdOfAllTable:this.tableId ,tableNameOfAllTable: this.tableName,))));
                                              },
                                              elevation: 0,
                                              child: SvgPicture.asset("assets/ss.svg",height: 6*Config.imageSizeMultipier,width: 6*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                )
                            ),

                          ),
                        ),flex: 1,

                      ),

                    ],
                  ),
                )
            );
          }else{
            return Scaffold(
                appBar: AppBar(
                  title: Text("All Table"),
                  elevation: 0,
                  actions: <Widget>[

                    new Container(),

                    Center(
                      child: new Text(
                        ReactiveUsername.Username??"gh",
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
                            child: InkWell(child: Text("Logout"),
                              onTap: ()async{

                                var pres =await SharedPreferences.getInstance();

                                pres.remove('token');


                                Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Login())));
                              },
                            ),

                          );
                        });
                      },
                    ),
                  ],
                ),
                body:Container(
                  margin: EdgeInsets.all(3*Config.blockSizeHorizental),
                  child:   Row(
                    children: [

                      Expanded(
                        child:    Container(

                          height: 70*Config.blockSizeHorizental,
                          child: FutureBuilder<List<GetAllTableData>>(
                              future: getAllTabbles(),
                              builder: (context, snapshot) {
                                try{

                                  print(snapshot.hasData);
                                  if (snapshot.hasData) {
                                    final us=snapshot.data;

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


                                      itemBuilder: (BuildContext context,int index){
                                        final all= us[index];

                                        return  Container(
                                          //  color: Colors.black,
                                          width: 20*Config.blockSizeVertical,
                                          height: 35*Config.blockSizeHorizental,
                                          child:  InkWell(
                                            onTap: (){
                                              // showWidget();
                                              if(all.isOpen==true){
                                                viewLayout=true;
                                                showWidget();


                                              }else{
                                                //maybe yo call hune bela samma build process complete vako hudaina so, teslaile yo error airako hola

                                                Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(tableData:all,userIdForAlltable: reactiveUserID.UserId,UsernameForAlltable: ReactiveUsername.Username,)));
                                              }

                                              setState(() {
                                                this.tableId=all.id;
                                                this.tableName=all.name;
                                              });


                                            },
                                            child:Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.blueAccent)
                                              ),

                                              width: 15*Config.blockSizeVertical,
                                              height: 25*Config.blockSizeHorizental,
                                              margin: EdgeInsets.only(left: .2*Config.textMultipier,top: .5*Config.textMultipier),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height:5*Config.blockSizeHorizental,
                                                  width: 5*Config.imageSizeMultipier,
                                                    child: Visibility(

                                                      child: Container(
                                                          margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                                                          child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)

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
                                                        child: SvgPicture.asset("assets/u.svg",height: 14*Config.imageSizeMultipier,width: 13*Config.imageSizeMultipier,alignment: Alignment.bottomCenter,color: Colors.purple,)

                                                    ),

                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),
                                                    color: Colors.blue,
                                                    child: Text(all.name??"ada"),
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
                                }catch( SocketException){
                                  print(Exception);

                                }

                                return Center(child: CircularProgressIndicator());
                              }

                          ),
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