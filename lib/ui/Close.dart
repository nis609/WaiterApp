import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant/ReactiveData/reactiveUserId.dart';
import 'package:restaurant/ReactiveData/reactive_userName.dart';
import 'package:restaurant/Services/GetBillByIdServices.dart';
import 'package:restaurant/Services/GetCloseTableServices.dart';
import 'package:restaurant/modal/GetBillById.dart';
import 'package:restaurant/modal/GetCloseTable.dart';
import 'package:restaurant/ui/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';
import 'Login.dart';

class Close extends StatefulWidget{
  final int userId;
  final String Username;

  const Close({Key key, this.userId,this.Username}) : super(key: key);
  @override
  _OpensState createState() => _OpensState();
}

class _OpensState extends State<Close> {
  bool viewVisible = false ;
  int tableId;
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

  Future<List<CloseTable>> getCloseTable() async{
    try{

      return await  GetCloseTableService().getall();
    }catch(SocketExcpetion){
      print(SocketExcpetion);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }
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
                title: Text("Close"),
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


                    // Row(
                    //   children: [
                    //     // InkWell(
                    //     //   onTap: (){
                    //     //     //showWidget();
                    //     //        Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));
                    //     //   },
                    //     //   child:Container(
                    //     //     decoration: BoxDecoration(
                    //     //         border: Border.all(color: Colors.blueAccent)
                    //     //     ),
                    //     //
                    //     //     width: 15*Config.blockSizeVertical,
                    //     //     height: 25*Config.blockSizeHorizental,
                    //     //     child: Column(
                    //     //       children: [
                    //     //         Container(
                    //     //             height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,
                    //     //             margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                    //     //             //child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)
                    //     //
                    //     //         ),
                    //     //         InkWell(
                    //     //           child: Container(
                    //     //             //margin: EdgeInsets.only(top:3*Config.blockSizeHorizental),
                    //     //               child: SvgPicture.asset("assets/u.svg",height: 14*Config.imageSizeMultipier,width: 13*Config.imageSizeMultipier,alignment: Alignment.bottomCenter,color: Colors.purple,)
                    //     //
                    //     //           ),
                    //     //
                    //     //         ),
                    //     //         Container(
                    //     //           margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),
                    //     //           color: Colors.blue,
                    //     //           child: Text("D1"),
                    //     //         )
                    //     //
                    //     //
                    //     //       ],
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //     // InkWell(
                    //     //   onTap: (){
                    //     //     //showWidget();
                    //     //       Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));
                    //     //   },
                    //     //   child:Container(
                    //     //     decoration: BoxDecoration(
                    //     //         border: Border.all(color: Colors.blueAccent)
                    //     //     ),
                    //     //     margin: EdgeInsets.only(left: .2*Config.textMultipier),
                    //     //     width: 15*Config.blockSizeVertical,
                    //     //     height: 25*Config.blockSizeHorizental,
                    //     //     child: Column(
                    //     //       children: [
                    //     //         Container(
                    //     //             margin: EdgeInsets.only(top:1*Config.blockSizeHorizental),
                    //     //             height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,
                    //     //            // child: SvgPicture.asset("assets/jj.svg",height: 5*Config.imageSizeMultipier,width: 5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.orangeAccent,)
                    //     //
                    //     //         ),
                    //     //         InkWell(
                    //     //           child: Container(
                    //     //             //margin: EdgeInsets.only(top:3*Config.blockSizeHorizental),
                    //     //               child: SvgPicture.asset("assets/u.svg",height: 14*Config.imageSizeMultipier,width: 13*Config.imageSizeMultipier,alignment: Alignment.bottomCenter,color: Colors.purple,)
                    //     //
                    //     //           ),
                    //     //
                    //     //         ),
                    //     //         Container(
                    //     //           margin: EdgeInsets.only(top:.5*Config.blockSizeHorizental),
                    //     //           color: Colors.blue,
                    //     //           child: Text("D1"),
                    //     //         )
                    //     //
                    //     //
                    //     //       ],
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //
                    //
                    //
                    //
                    //   ],
                    // ),


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
          return Scaffold(
              appBar: AppBar(
                title: Text("Close"),
                elevation: 0,
                actions: <Widget>[

                  new Container(),

                  Center(
                    child: new Text(
                      ReactiveUsername.Username??"ghhh",
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
                child: Column(

                  children: [
                    Container(
                      height: 70*Config.blockSizeHorizental,
                      child: FutureBuilder<List<CloseTable>>(
                          future: getCloseTable(),
                          builder: (context, snapshot) {
                            try{

                              if (snapshot.hasData) {
                                final closeTableIndex=snapshot.data;

                                return GridView.builder(
                                  controller: new ScrollController(
                                      keepScrollOffset: false),
                                  scrollDirection: Axis.vertical,

                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 5.0,
                                    crossAxisSpacing: 5.0,

                                  ),
                                  itemCount: closeTableIndex == null ? 0 : closeTableIndex.length,


                                  itemBuilder: (BuildContext context,int index){
                                    final closeTableDetail= closeTableIndex[index];


                                    return  Container(
                                      //  color: Colors.black,
                                      width: 15*Config.blockSizeVertical,
                                      height: 25*Config.blockSizeHorizental,
                                      child:  InkWell(
                                        onTap: (){
                                          setState(() {

                                            tableId=closeTableDetail.id;


                                          });

                                          Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu(closeTable:closeTableDetail,id: reactiveUserID.UserId,Username: ReactiveUsername.Username,)));

                                        },
                                        child: Container(
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
                                                  visible: closeTableDetail.isOpen,
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
                                                child: Text(closeTableDetail.name),
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

                            return Center(child: CircularProgressIndicator(
                              backgroundColor: Colors.yellow,

                            ));
                          }

                      ),
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

  }
}