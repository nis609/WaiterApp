import 'package:adobe_xd/pinned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/ReactiveData/reactiveUrlSetting.dart';
import 'package:restaurant/ReactiveData/reactiveUserId.dart';
import 'package:restaurant/ReactiveData/reactive_token.dart';
import 'package:restaurant/ReactiveData/reactive_userName.dart';
import 'package:restaurant/Services/LoginServices.dart';
import 'package:restaurant/Services/api_services.dart';
import 'package:restaurant/modal/LoginModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';
import 'Home.dart';

class Login extends StatefulWidget{

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String password ;
SharedPreferences share;
  String username ;
  TextEditingController url = new TextEditingController();
  TextEditingController passwords = new TextEditingController();
  TextEditingController userNames = new TextEditingController();

  Future <LoginModal> perform(String name,String password) async {
    try {
    //  print(vendors.url);

      return await LoginService().creates(name,password);

    } catch (Exception) {
      {
        print(Exception);
      }
    }
  }


  Future <List<CreateUser>> performTaskForCreateUser(String name,String password) async {
    try {
      //  print(vendors.url);

      return await LoginService().CreateUsers(name,password);
    } catch (Exception) {
      {
        print(Exception);
      }
    }
  }
  Future<void> SettingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            elevation: 5,
            title: Text("API Base URL"),

            content: SingleChildScrollView(
                child: SizedBox(
                  width: 30 * Config.textMultipier,
                  height: 10 * Config.textMultipier,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        onTap: () {
                          // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Country())));
                        },
                        controller: url,
                        decoration: InputDecoration(
                            labelText: "Enter URL",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),

                    ],
                  ),
                )),
            actions: <Widget>[
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(1 * Config.textMultipier),
                    color:Color.fromRGBO(0, 153, 204, 01),
                    child: TextButton(
                      child: Text('OK',style: TextStyle(color: Colors.white),),
                      onPressed: () {
                      reactiveUrl.addurl(url.text);
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Login())));
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(1 * Config.textMultipier),
                    color:  Color.fromRGBO(180, 0, 0, 01),
                    child: TextButton(
                      child: Text('Cancel',style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                ],
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    save(String token) async {
      final pre =await SharedPreferences.getInstance();
      final key='token';
      final value=token;
      pre.setString(key,value);

      // final pres =await SharedPreferences.getInstance();
      // final keys='token';
      // final values=pres.get(keys)??0;
      // print('read:$values');
      reactiveToken.addToken(token);
    }
    saveUser(String Username) async {
      final pre =await SharedPreferences.getInstance();
      final userName='Username';
      final user=userName;

      pre.setString(user,userName);


      final pres =await SharedPreferences.getInstance();
      final keys='Username';
      final values=pres.get(keys)??0;

    }
setState(() {
  userNames.text=username;
});
    // TODO: implement build
    if (MediaQuery
        .of(context)
        .orientation == Orientation.portrait) {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          return Scaffold(
              backgroundColor: Color.fromRGBO(59, 169, 222,01),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 10*Config.textMultipier),
                      //color: Colors.blue,
                      child: Image.asset('assets/wq.jpeg'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(

                        children: [
                          Container(
                            //color: Colors.red,
                            height: 5*Config.textMultipier,
                          ),
                          Stack(
                            children: [

                              Center(


                                child: Container(
                                  margin: EdgeInsets.only(top:3*Config.textMultipier),
                                  height: 40*Config.textMultipier,
                                  width: 45*Config.textMultipier,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white
                                      )
                                  ),

                                  child: Container(
                                    margin: EdgeInsets.all(2*Config.textMultipier),

                                    child: Column(
                                      children: [
                                        Container(
                                            alignment:Alignment.centerLeft,
                                            child: Text("Username")),
                                        Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0)),
                                          child: Row(
                                            children: [
                                              Container(

                                                padding:EdgeInsets.fromLTRB(15,4,15,0),
                                                height: 8*Config.textMultipier,
                                                alignment: Alignment.centerLeft,
                                                width:40*Config.textMultipier,

                                                child: TextField(
                                                  onTap: (){
                                                    // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Country())));
                                                  },
                                                  controller: userNames,
                                                  decoration: InputDecoration(
                                                      hintText: "Enter yourname",
                                                      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))

                                                  ),

                                                ),

                                              ),
                                            ],
                                          ),

                                        ),
                                        Container(
                                            alignment:Alignment.centerLeft,
                                            margin: EdgeInsets.only(top:2*Config.textMultipier),
                                            child: Text("Password")),

                                        Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0)),
                                          child: Container(

                                            padding:EdgeInsets.fromLTRB(15,4,15,0),
                                            height: 8*Config.textMultipier,
                                            alignment: Alignment.centerLeft,
                                            width:40*Config.textMultipier,

                                            child: TextField(
                                              onTap: (){

                                              },
                                              controller: passwords,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  hintText: "Enter Password",

                                                  border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))

                                              ),

                                            ),

                                          ),

                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top:5*Config.textMultipier),
                                          child: RaisedButton(

                                            color: Colors.grey[300],
                                            child:

                                            Container(
                                                width: 20*Config.textMultipier,
                                                height:  7*Config.textMultipier,

                                                alignment: Alignment.center,
                                                child: Text("Login",style: TextStyle(color: Colors.blue),)),
                                            onPressed: (){

                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return FutureBuilder<LoginModal>(
                                                      future: perform(userNames.text,passwords.text),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          final us=snapshot.data;
                                                              save(us.token);

                                                         return(Home());

                                                        }
                                                        return CircularProgressIndicator();
                                                      });
                                                },
                                              );




                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top:1*Config.textMultipier,
                                left:8*Config.textMultipier ,
                                child: Container(
                                    color: Color.fromRGBO(59, 169, 222,01),
                                    child: Text("Login",style: TextStyle(fontSize: 3*Config.textMultipier),)),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  )
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
                backgroundColor:Color.fromRGBO(59, 169, 222,01),

              body:
              SingleChildScrollView(
                child: Container(child:   Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/frontDesk.svg",height: 25*Config.imageSizeMultipier,width: 25*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,),

                        //    SvgPicture.asset("assets/sofwena.svg",height: 2.5*Config.imageSizeMultipier,width: 2.5*Config.imageSizeMultipier,alignment: Alignment.center,color: Colors.white,),
                            SizedBox(height: 2.5*Config.imageSizeMultipier ,width: 2.5*Config.imageSizeMultipier),
                            Text("Sofwena Sales", style: TextStyle(fontFamily: "Cooper",color: Colors.white,fontSize: 5*Config.imageSizeMultipier ),),

                            Text("Enchancing Your F & B Experience", style: TextStyle(fontFamily: "Times" ,color: Colors.white,fontSize: 2.5*Config.imageSizeMultipier,fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Column(

                        children: [
                          Container(
                            height: 5*Config.textMultipier,

                          ),
                          Container(
                            height: 5*Config.textMultipier,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 20),
                            child:InkWell(
                                onTap: (){
                                  SettingDialog();
                                },
                                child: Text("Setting",style: TextStyle(color: Colors.white),)),
                          ),
                          Stack(
                            children: <Widget>[

                              Center(


                                child: Container(
                                  margin: EdgeInsets.only(top:3*Config.textMultipier),
                                  height: 43*Config.textMultipier,
                                  width: 40*Config.textMultipier,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white
                                      )
                                  ),

                                  child: Container(
                                    margin: EdgeInsets.all(2*Config.textMultipier),

                                    child: Column(
                                      children: [
                                        Container(
                                            alignment:Alignment.centerLeft,
                                            child: Text("Username",style: TextStyle(color: Colors.white),)),
                                        Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: Container(

                                            padding:EdgeInsets.fromLTRB(15,4,15,0),
                                            height: 8*Config.textMultipier,
                                            alignment: Alignment.centerLeft,
                                            width:40*Config.textMultipier,

                                            child: TextField(
                                              onTap: (){
                                                // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Country())));
                                              },

                                              controller: userNames,

                                              decoration: InputDecoration(
                                                  hintText: "Enter Username",
                                                  hintStyle: TextStyle(color: Colors.grey[300]),

                                                  border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                      ,borderSide: BorderSide.none
                                                  )


                                              ),

                                            ),

                                          ),

                                        ),
                                        Container(
                                            alignment:Alignment.centerLeft,
                                            margin: EdgeInsets.only(top:2*Config.textMultipier),
                                            child: Text("Password",style: TextStyle(color: Colors.white))),

                                        Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0)),
                                          child: Container(

                                            padding:EdgeInsets.fromLTRB(15,4,15,0),
                                            height: 8*Config.textMultipier,
                                            alignment: Alignment.centerLeft,
                                            width:40*Config.textMultipier,

                                            child: TextField(

                                              onTap: (){
                                                // Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Country())));
                                              },

                                              controller: passwords,
                                              obscureText: true,


                                              decoration: InputDecoration(
                                                  hintText: "Enter Password",

                                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                                  border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)
                                                      ,borderSide: BorderSide.none
                                                  )

                                              ),

                                            ),

                                          ),

                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0)),
                                          margin: EdgeInsets.only(top:5*Config.textMultipier),
                                          child: RaisedButton(

                                            color: Colors.white,
                                            child:

                                            Container(
                                                width:40*Config.textMultipier,
                                                height:  7*Config.textMultipier,


                                                alignment: Alignment.center,
                                                child: Text("Login",style: TextStyle(color: Colors.blue),)),
                                            onPressed: () async {


                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                        return Center(child: CircularProgressIndicator(
                                                          backgroundColor: Colors.yellow,

                                                        ));
                                                },
                                              );
                                              final LoginModal user =await  LoginService().creates(userNames.text,passwords.text);

                                              if(userNames.text.isNotEmpty || passwords.text.isNotEmpty != null){
                                                if(user.token.isNotEmpty){

                                                //  final List<CreateUser> usersList =await  performTaskForCreateUser(userNames.text,passwords.text);
                                                 if(user.data!=null && user.data.isNotEmpty){


                                                   reactiveToken.addToken(user.token);
                                                   ReactiveUsername.addUsername(user.data.first.userName);
                                                   reactiveUserID.addUserId(user.data.first.userId);

                                                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>(Home(
                                                  id: reactiveUserID.UserId,
                                                    Username:  ReactiveUsername.Username,

                                                  )  )));

                                                }else{
                                                   print("failed");
                                                 }
                                                }else{
                                                  showDialog(context: context,builder: (ctx){
                                                    return  Dialog(

                                                        elevation: 0,

                                                        child: Container(
                                                            height: 100,
                                                            width: 500,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                    height:20,
                                                                    child: Text("Alert!!!!",style: TextStyle(color: Colors.red),)),
                                                                SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Container( height:30,child: Text("Invalid Username Or password")),
                                                                RaisedButton(
                                                                  child: Text("Ok"),
                                                                  onPressed: (){
                                                                    Navigator.pop(context);
                                                                  },
                                                                )
                                                              ],
                                                            ))
                                                    );
                                                  });
                                                }


                                              }else{
                                               SettingDialog();
                                              }








                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),


                        ],
                      ),
                      flex: 1,
                    ),

                  ],
                ),),
              )


          );
        }
        );
      }

      );
    }

  }
  }


