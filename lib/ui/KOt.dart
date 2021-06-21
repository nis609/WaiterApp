import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:restaurant/ReactiveData/MenuDetailItem.dart';
import 'package:restaurant/Services/GetItemDetailServices.dart';
import 'package:restaurant/Services/GetMenuItemService.dart';

import 'package:restaurant/Services/GetMenuService.dart';
import 'package:restaurant/Services/GetSubMenuServices.dart';
import 'package:restaurant/Services/getKotMenuServices.dart';
import 'package:restaurant/Services/searchItemServices.dart';
import 'package:restaurant/modal/GetItem.dart';
import 'package:restaurant/modal/GetItem.dart';
import 'package:restaurant/modal/GetItemDetail.dart';
import 'package:restaurant/modal/GetMenu.dart';
import 'package:restaurant/modal/GetSubMenu.dart';
import 'package:restaurant/modal/getKotMenu.dart';
import 'package:restaurant/modal/getSearchModal.dart';
import 'package:restaurant/ui/Bill.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';
import 'Home.dart';
import 'Login.dart';

class Kot extends StatefulWidget {
  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Kot> {
  int kotSelected = 0;
  bool isexpand=false;
  int isexpandformenu;
  int kotSubMenuSelected = 0;
  int kotMenuItemSelected = 0;
int subMenuListItemIdofKots;
  String menuParamter = "KOT";

  Future<List<ItemData>> getallItemsDetailsOfKot(int subMenuListItemIdofKot) async {
    try {
      return await GetItemDetailServices().getall(subMenuListItemIdofKot);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }







  Future<List<KotMenu>> getmenutabblesOfKot() async {
    try {
      print("24");

      return await getKotMenuServices().getKotMenus();
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  Future<List<SubMenuDetail>> submenuofKot(int menuId,int index) async {

    try {
      // print("26");
      return await GetSubMenuServices().getall(menuId);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  List<SubMenuDetail> s;
  List<MenuItem> se;
  TextEditingController searchItemNamesController = new TextEditingController();

  Future<List<SearchItem>> serachOfItem(String searchItemName) async {
    try {
      // print("26");
      return await searchItemServices().searchItem(searchItemName);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  Future<List<MenuItem>> menuItemofKot(int kotSubMenuId,int index) async {
    try {
      print("8-");
      return await GetMenuItemServices().getall(kotSubMenuId);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  Future<List<SearchItem>> _getSuggestions(String query) async {
    List<SearchItem> matches = new List<SearchItem>();

    matches.addAll(await searchItemServices().searchItem(query));

    return matches;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          print("Suggestion list ${searchItemServices().categories}");

          Config().int(constraints, orientation);
          return Scaffold(
            body: Column(
              children: <Widget>[
                Container(
                  width: 100 * Config.blockSizeHorizental,
                  height: 100 * Config.blockSizeVertical,
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(1 * Config.textMultipier),
                          child: TypeAheadField<SearchItem>(
                            textFieldConfiguration: TextFieldConfiguration(
                                controller: this.searchItemNamesController,
                                decoration: InputDecoration(
                                    labelText: 'Enter Item Name')),
                            suggestionsCallback: (pattern) {
                              return serachOfItem(pattern);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.name),
                              );
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (suggestion) {
                              this.searchItemNamesController.text =
                                  suggestion.name;
                              //check garnus ta

                              //sir ayo arko chahi
                            },
                          )),
                      Container(
                        // color: Colors.black,
                        height: 100 * Config.blockSizeVertical,
                        child: FutureBuilder<List<KotMenu>>(
                            future: getmenutabblesOfKot(),
                            builder: (context, snapshot) {
                              try {
                                print("as");
                                print(snapshot.hasData);
                                if (snapshot.hasData) {
                                  final usa = snapshot.data;
                                  print("aaa");

                                  return ListView.builder(
                                    controller: new ScrollController(
                                        keepScrollOffset: false),
                                    //scrollDirection: Axis.horizontal,
                                    itemCount: usa == null ? 0 : usa.length,

                                    itemBuilder:
                                        (BuildContext context, int indexs) {
                                      final menus = usa[indexs];



                                      return Container(
                                        width: 15 * Config.blockSizeVertical,
                                        height: 60 * Config.blockSizeHorizental,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {


                                            });
                                            // showWidget();
                                            // Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));
                                          },
                                          child: ExpansionTile(

                                            title: Text(menus.name),
                                            children: [
                                              Container(
                                                //    color: Colors.pink,
                                                width: 15 *
                                                    Config.blockSizeVertical,
                                                height: 40 *
                                                    Config.blockSizeHorizental,
                                                child: FutureBuilder<List<SubMenuDetail>>(
                                                    future:
                                                        submenuofKot(menus.id,indexs),
                                                    builder:
                                                        (context, snapshot) {
                                                      try {
                                                        print("menu");
                                                        print(snapshot.hasData);
                                                        if (snapshot.hasData) {
                                                          final subMenuindexList =
                                                              snapshot.data;
                                                          //  print("menun");

                                                          return ListView
                                                              .builder(
                                                            controller:
                                                                new ScrollController(
                                                                    keepScrollOffset:
                                                                        false),
                                                            //scrollDirection: Axis.horizontal,
                                                            itemCount:
                                                                subMenuindexList ==
                                                                        null
                                                                    ? 0
                                                                    : subMenuindexList
                                                                        .length,

                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int subMenuindex) {
                                                              final submenu =
                                                                  subMenuindexList[
                                                                      subMenuindex];


                                                              print(submenu.id);
                                                              print("submenu");

                                                              return ExpansionTile(
                                                                initiallyExpanded:
                                                                    kotSubMenuSelected ==
                                                                        indexs,
                                                                onExpansionChanged:
                                                                    (Key) {
                                                                  setState(() {
                                                                    kotSubMenuSelected = kotSubMenuSelected ==
                                                                            indexs
                                                                        ? null
                                                                        : indexs;
                                                                  });
                                                                },
                                                                title: Text(
                                                                  submenu.name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                children: [
                                                                  Container(
                                                                    width: 15 *
                                                                        Config
                                                                            .blockSizeVertical,
                                                                    height: 50 *
                                                                        Config
                                                                            .blockSizeHorizental,
                                                                    child: FutureBuilder<
                                                                            List<
                                                                                MenuItem>>(
                                                                        future:
                                                                            menuItemofKot( submenu.id,subMenuindex),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          try {
                                                                            print("menu");
                                                                            print(snapshot.hasData);
                                                                            if (snapshot.hasData) {
                                                                              final menuItemList = snapshot.data;
                                                                              print("ok");

                                                                              return ListView.builder(
                                                                                controller: new ScrollController(keepScrollOffset: false),
                                                                                //scrollDirection: Axis.horizontal,
                                                                                itemCount: menuItemList == null ? 0 : menuItemList.length,

                                                                                itemBuilder: (BuildContext context, int index) {
                                                                                  final menuitem = menuItemList[index];

                                                                                  // saves(submenu.id.toString());

                                                                                  return Container(
                                                                                      width: 15 * Config.blockSizeVertical,
                                                                                      height: 15 * Config.blockSizeHorizental,
                                                                                      child: Center(
                                                                                          child: ListTile(
                                                                                        title: Text(menuitem.name),
                                                                                        onTap: () {

                                                                                          setState(() {});
                                                                                        },
                                                                                      )));
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
          );
        });
      });
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Config().int(constraints, orientation);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //

                  Container(
                    width: 100 * Config.blockSizeHorizental,
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(1 * Config.textMultipier),
                            child: TypeAheadField<SearchItem>(
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: this.searchItemNamesController,
                                  decoration: InputDecoration(
                                      labelText: 'Enter Item Name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              suggestionsCallback: (pattern) {
                                return serachOfItem(pattern);
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: InkWell(
                                    child: Text(suggestion.name),
                                    onTap: () {
                                      List<ItemData> listSearchItem = [];
                                      listSearchItem =
                                          menudetailitem.allItemsDetail ?? [];
                                      ItemData itemForSearch = new ItemData();
                                      final duplicateItem = listSearchItem.firstWhere(
                                              (item) => item.id == suggestion.id, orElse: () => null);
                                      if(duplicateItem.qty!=null){
                                        duplicateItem.qty++;
                                      }else {
                                        itemForSearch.id = suggestion.id;
                                        itemForSearch.itemName =
                                            suggestion.name;
                                        itemForSearch.rate = suggestion.rate;
                                        itemForSearch.qty = 1;
                                        itemForSearch.isModifier==false;
                                      }

                                      listSearchItem.add(itemForSearch);

                                      menudetailitem.addOrder(listSearchItem);
                                    },
                                  ),
                                );
                              },
                              transitionBuilder:
                                  (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (suggestion) {
                                this.searchItemNamesController.text =
                                    suggestion.name;
                                //check garnus ta

                                //sir ayo arko chahi
                              },
                            )),
                        Container(
                          // color: Colors.black,
                          height: 60 * Config.blockSizeVertical,
                          child: FutureBuilder<List<KotMenu>>(
                              future: getmenutabblesOfKot(),
                              builder: (context, snapshot) {
                                try {
                                  if (snapshot.hasData) {
                                    final usa = snapshot.data;

                                    return ListView.builder(
                                      controller: new ScrollController(
                                          keepScrollOffset: false),
                                      //scrollDirection: Axis.horizontal,
                                      itemCount: usa == null ? 0 : usa.length,

                                      itemBuilder:
                                          (BuildContext context, int indexs) {
                                        final menus = usa[indexs];

                                      //  save(menus.id.toString());

                                        return Container(
                                          child: InkWell(

                                              // showWidget();
                                              // Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));

                                            child: ExpansionTile(


                                              title:InkWell(onTap:()async{

          s = await submenuofKot(menus.id,indexs);
          setState(() {});

                                              },child: Container( height: 10 * Config.blockSizeHorizental,child: Text(menus.id.toString()))),
                                              children: [
                                                Container(
                                                  //    color: Colors.pink,
                                                  width: 40 * Config.blockSizeVertical,
                                                  height: 300,
                                                  child:ListView
                                                      .builder(
                                                    controller:
                                                    new ScrollController(keepScrollOffset: false),
                                                    //scrollDirection: Axis.horizontal,
                                                    itemCount: s == null ? 0 : s.length,

                                                    itemBuilder: (BuildContext context, int subMenuindex) {
                                                      final submenu = s[subMenuindex];



                                                      return InkWell(
                                                        onTap: () async {

                                                          se = await menuItemofKot(submenu.id,subMenuindex);
                                                        },
                                                        child: ExpansionTile(
                                                          title: Container(child: Text(submenu.name.toString())),
                                                          children: [
                                                            Container(
                                                              width: 40 * Config.blockSizeVertical,
                                                              height: 200,
                                                              child:  ListView.builder(
                                                                controller: new ScrollController(keepScrollOffset: false),
                                                                //scrollDirection: Axis.horizontal,
                                                                itemCount: se == null ? 0 : se.length,

                                                                itemBuilder: (BuildContext context, int index) {
                                                                  final menuitem = se[index];

                                                                  // saves(submenu.id.toString());

                                                                  return Container(
                                                                      width: 40 * Config.blockSizeVertical,
                                                                      height: 40 ,
                                                                      child: Center(
                                                                          child: ListTile(
                                                                            title: Text(menuitem.name,style: TextStyle(fontSize: 15),),
                                                                            onTap: () async {

                                                                              this.subMenuListItemIdofKots=menuitem.id;
                                                                              final List<ItemData> user =await  getallItemsDetailsOfKot( this.subMenuListItemIdofKots);
                                                                              if(user.isNotEmpty){
                                                                                final getallItemsDetailsOfKotIndex =
                                                                                    snapshot.data;
                                                                                List<ItemData> getitemOfKot = [];
                                                                                getitemOfKot =
                                                                                    menudetailitem.allItemsDetail ?? [];
                                                                                final duplicateItem = getitemOfKot.firstWhere((item) => item.id == user.first
                                                                                    .id,
                                                                                    orElse: () => null);

                                                                                if(duplicateItem!=null){
                                                                                  duplicateItem.qty++;
                                                                                }else{
                                                                                  getitemOfKot.add(ItemData(
                                                                                    id:user.first.id,
                                                                                    code: user.first.code,
                                                                                    details:user.first.details,
                                                                                    unitId: user.first.unitId,
                                                                                    subMenu:user.first.subMenu,
                                                                                    subMenuId:
                                                                                    user.first.subMenuId,
                                                                                    rate: user.first.rate,
                                                                                    itemName:
                                                                                    user.first.itemName,
                                                                                    modifierId: 1,
                                                                                    qty:user.first.qty,
                                                                                    subTotal:
                                                                                    user.first.qty *
                                                                                        user.first.rate,
                                                                                    isModifier:
                                                                                    user.first.isModifier,
                                                                                    comment: user.first.comment
                                                                                        .toString(),
                                                                                    commentId:
                                                                                    user.first.commentId,
                                                                                    isComment:
                                                                                    user.first.isComment ??
                                                                                        false,
                                                                                    isNew:user.first.isNew ??
                                                                                        true,
                                                                                    orderType:
                                                                                    user.first.orderType ??
                                                                                        "BOT",
                                                                                  ));}

                                                                                menudetailitem.addOrder(getitemOfKot);

                                                                              }

                                                                            },
                                                                          )));
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                  ,
                                                ),
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

                                return Center(
                                    child: CircularProgressIndicator());
                              }),
                        ),

                        Container(
                          // color: Colors.black,
                          height: 60 * Config.blockSizeVertical,
                          child: FutureBuilder<List<KotMenu>>(
                              future: getmenutabblesOfKot(),
                              builder: (context, snapshot) {
                                try {
                                  if (snapshot.hasData) {
                                    final usa = snapshot.data;

                                    return ListView.builder(
                                      controller: new ScrollController(
                                          keepScrollOffset: false),
                                      //scrollDirection: Axis.horizontal,
                                      itemCount: usa == null ? 0 : usa.length,

                                      itemBuilder:
                                          (BuildContext context, int indexs) {
                                        final menus = usa[indexs];

                                        //  save(menus.id.toString());

                                        return Container(
                                          child: InkWell(

                                            // showWidget();
                                            // Navigator.push(context, new MaterialPageRoute(builder: (context)=> Menu()));

                                            child: ExpansionTile(


                                              title:InkWell(onTap:()async{

                                                s = await submenuofKot(menus.id,indexs);
                                                setState(() {});

                                              },child: Container( height: 10 * Config.blockSizeHorizental,child: Text(menus.id.toString()))),
                                              children: [
                                                Container(
                                                  //    color: Colors.pink,
                                                  width: 40 * Config.blockSizeVertical,
                                                  height: 300,
                                                  child:ListView
                                                      .builder(
                                                    controller:
                                                    new ScrollController(keepScrollOffset: false),
                                                    //scrollDirection: Axis.horizontal,
                                                    itemCount: s == null ? 0 : s.length,

                                                    itemBuilder: (BuildContext context, int subMenuindex) {
                                                      final submenu = s[subMenuindex];



                                                      return InkWell(
                                                        onTap: () async {

                                                          se = await menuItemofKot(submenu.id,subMenuindex);
                                                        },
                                                        child: ExpansionTile(
                                                          title: Container(child: Text(submenu.name.toString())),
                                                          children: [
                                                            Container(
                                                              width: 40 * Config.blockSizeVertical,
                                                              height: 200,
                                                              child:  ListView.builder(
                                                                controller: new ScrollController(keepScrollOffset: false),
                                                                //scrollDirection: Axis.horizontal,
                                                                itemCount: se == null ? 0 : se.length,

                                                                itemBuilder: (BuildContext context, int index) {
                                                                  final menuitem = se[index];

                                                                  // saves(submenu.id.toString());

                                                                  return Container(
                                                                      width: 40 * Config.blockSizeVertical,
                                                                      height: 40 ,
                                                                      child: Center(
                                                                          child: ListTile(
                                                                            title: Text(menuitem.name,style: TextStyle(fontSize: 15),),
                                                                            onTap: () async {

                                                                              this.subMenuListItemIdofKots=menuitem.id;
                                                                              final List<ItemData> user =await  getallItemsDetailsOfKot( this.subMenuListItemIdofKots);
                                                                              if(user.isNotEmpty){
                                                                                final getallItemsDetailsOfKotIndex =
                                                                                    snapshot.data;
                                                                                List<ItemData> getitemOfKot = [];
                                                                                getitemOfKot =
                                                                                    menudetailitem.allItemsDetail ?? [];
                                                                                final duplicateItem = getitemOfKot.firstWhere((item) => item.id == user.first
                                                                                    .id,
                                                                                    orElse: () => null);

                                                                                if(duplicateItem!=null){
                                                                                  duplicateItem.qty++;
                                                                                }else{
                                                                                  getitemOfKot.add(ItemData(
                                                                                    id:user.first.id,
                                                                                    code: user.first.code,
                                                                                    details:user.first.details,
                                                                                    unitId: user.first.unitId,
                                                                                    subMenu:user.first.subMenu,
                                                                                    subMenuId:
                                                                                    user.first.subMenuId,
                                                                                    rate: user.first.rate,
                                                                                    itemName:
                                                                                    user.first.itemName,
                                                                                    modifierId: 1,
                                                                                    qty:user.first.qty,
                                                                                    subTotal:
                                                                                    user.first.qty *
                                                                                        user.first.rate,
                                                                                    isModifier:
                                                                                    user.first.isModifier,
                                                                                    comment: user.first.comment
                                                                                        .toString(),
                                                                                    commentId:
                                                                                    user.first.commentId,
                                                                                    isComment:
                                                                                    user.first.isComment ??
                                                                                        false,
                                                                                    isNew:user.first.isNew ??
                                                                                        true,
                                                                                    orderType:
                                                                                    user.first.orderType ??
                                                                                        "BOT",
                                                                                  ));}

                                                                                menudetailitem.addOrder(getitemOfKot);

                                                                              }

                                                                            },
                                                                          )));
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                  ,
                                                ),
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

                                return Center(
                                    child: CircularProgressIndicator());
                              }),
                        ),
                        // Container(
                        //   height: 1,
                        //   width: 1,
                        //   child: FutureBuilder<List<ItemData>>(
                        //       future: getallItemsDetailsOfKot(this.subMenuListItemIdofKots),
                        //       builder: (context, snapshot) {
                        //         try {
                        //           final getallItemsDetailsOfKotIndex =
                        //               snapshot.data;
                        //           List<ItemData> getitemOfKot = [];
                        //           getitemOfKot =
                        //               menudetailitem.allItemsDetail ?? [];
                        //
                        //           return ListView.builder(
                        //             itemCount:
                        //                 getallItemsDetailsOfKotIndex.length,
                        //             itemBuilder:
                        //                 (BuildContext context, int index) {
                        //               final duplicateItem =
                        //                   getitemOfKot.firstWhere(
                        //                       (item) =>
                        //                           item.id ==
                        //                           getallItemsDetailsOfKotIndex[
                        //                                   index]
                        //                               .id,
                        //                       orElse: () => null);
                        //               if (duplicateItem != null) {
                        //                 duplicateItem.qty++;
                        //               } else {
                        //                 getitemOfKot.add(ItemData(
                        //                   id: getallItemsDetailsOfKotIndex[
                        //                           index]
                        //                       .id,
                        //                   code: getallItemsDetailsOfKotIndex[
                        //                           index]
                        //                       .code,
                        //                   details: getallItemsDetailsOfKotIndex[
                        //                           index]
                        //                       .details,
                        //                   unitId: getallItemsDetailsOfKotIndex[
                        //                           index]
                        //                       .unitId,
                        //                   subMenu: getallItemsDetailsOfKotIndex[
                        //                           index]
                        //                       .subMenu,
                        //                   subMenuId:
                        //                       getallItemsDetailsOfKotIndex[
                        //                               index]
                        //                           .subMenuId,
                        //                   rate: getallItemsDetailsOfKotIndex[
                        //                           index]
                        //                       .rate,
                        //                   itemName:
                        //                       getallItemsDetailsOfKotIndex[
                        //                               index]
                        //                           .itemName,
                        //                   modifierId: 1,
                        //                   qty: getallItemsDetailsOfKotIndex[
                        //                           index]
                        //                       .qty,
                        //                   subTotal:
                        //                       getallItemsDetailsOfKotIndex[
                        //                                   index]
                        //                               .qty *
                        //                           getallItemsDetailsOfKotIndex[
                        //                                   index]
                        //                               .rate,
                        //                   isModifier:
                        //                       getallItemsDetailsOfKotIndex[
                        //                               index]
                        //                           .isModifier,
                        //                   comment: getallItemsDetailsOfKotIndex[
                        //                           index]
                        //                       .comment
                        //                       .toString(),
                        //                   commentId:
                        //                       getallItemsDetailsOfKotIndex[
                        //                               index]
                        //                           .commentId,
                        //                   isComment:
                        //                       getallItemsDetailsOfKotIndex[
                        //                                   index]
                        //                               .isComment ??
                        //                           false,
                        //                   isNew: getallItemsDetailsOfKotIndex[
                        //                               index]
                        //                           .isNew ??
                        //                       true,
                        //                   orderType:
                        //                       getallItemsDetailsOfKotIndex[
                        //                                   index]
                        //                               .orderType ??
                        //                           "BOT",
                        //                 ));
                        //               }
                        //
                        //
                        //               menudetailitem.addOrder(getitemOfKot);
                        //               getallItemsDetailsOfKotIndex.retainWhere(
                        //                   (element) =>
                        //                       getitemOfKot.remove(element.id));
                        //             },
                        //           );
                        //
                        //           menudetailitem.addOrder(getitemOfKot);
                        //
                        //           print(
                        //               getallItemsDetailsOfKotIndex.toString());
                        //           // mos.add(ItemData(
                        //           //     id:uses[0].id,
                        //           //     code: uses[0].code,
                        //           //     details: uses[0].details,
                        //           //     unit: uses[0].unit,
                        //           //     subMenu: uses[0].subMenu,
                        //           //     subMenuId: uses[0].subMenuId,
                        //           //     rate: uses[0].rate,
                        //           //     itemName: uses[0].itemName
                        //           //
                        //           // )    );
                        //
                        //           return Container();
                        //         } catch (Exception) {
                        //           print(Exception);
                        //         }
                        //
                        //         return Container();
                        //       }),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
    }
  }
}


