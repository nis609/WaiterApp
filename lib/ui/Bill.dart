import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:restaurant/ReactiveData/MenuDetailItem.dart';
import 'package:restaurant/Services/GetItemDetailServices.dart';
import 'package:restaurant/Services/GetMenuItemService.dart';

import 'package:restaurant/Services/GetSubMenuServices.dart';
import 'package:restaurant/Services/getKotMenuServices.dart';
import 'package:restaurant/Services/searchItemServices.dart';
import 'package:restaurant/modal/GetItem.dart';
import 'package:restaurant/modal/GetItemDetail.dart';
import 'package:restaurant/modal/GetSubMenu.dart';
import 'package:restaurant/modal/getKotMenu.dart';
import 'package:restaurant/modal/getSearchModal.dart';


import '../size_config.dart';

class Kotss extends StatefulWidget {
  @override
  _Menus createState() => _Menus();
}

class _Menus extends State<Kotss> {
  bool sun;
  bool i=false;
  bool kotMenuList=false;
  bool mun;
  int kotSelected = -1;
  bool isexpand=false;
  List<SubMenuDetail> submenu=[];
  List<KotMenu> kotMenu=[];
  int isexpandformenu;
  int kotSubMenuSelected = 0;
  int kotMenuItemSelected = 0;
  int subMenuListItemIdofKots;
  String menuParamter = "KOT";
  List<SubMenuDetail> sub=[];
  Future<List<ItemData>> getallItemsDetailsOfKot(int subMenuListItemIdofKot) async {
    try {
      return await GetItemDetailServices().getall(subMenuListItemIdofKot);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }




  List<KotMenu> kotsMenu=[];
  bool savekotsMen=false;


  Future<List<KotMenu>> getmenutabblesOfKot() async {
    try {


      return await getKotMenuServices().getKotMenus();
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  Future<List<SubMenuDetail>> submenuofKot(int menuId,int index) async {

    try {
      if(index!=null) {
        // print("26");
        return await GetSubMenuServices().getalls(menuId,index);
      }
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  List<SubMenuDetail> s;
  List<MenuItem> se;
int _activeMeterIndex=-1;
  int activeMeterIndex=-1;
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
      if(index!=null) {
        return await GetMenuItemServices().getalls(kotSubMenuId,index);
      }
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  Future<List<SearchItem>> _getSuggestions(String query) async {
    List<SearchItem> matches = new List<SearchItem>();

    matches.addAll(await searchItemServices().searchItem(query));

    return matches;
  }
  ValueNotifier<Key> _expanded = ValueNotifier(null);
  ValueNotifier<Key> expanded = ValueNotifier(null);
  Map<int, bool> expansionState = Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    s;
    se;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {


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



                                                              return ExpansionTile(
                                                                key:Key("$subMenuindex"),


                                                                onExpansionChanged:
                                                                    (e) {
                                                                  setState(() {
                                                                    kotSubMenuSelected ==
                                                                        subMenuindex
                                                                        ? null
                                                                        : subMenuindex;
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

                                                                            if (snapshot.hasData) {
                                                                              final menuItemList = snapshot.data;


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
                                      labelText: 'Enter Item Name'
                                  )
                              ),
                              suggestionsCallback: (pattern) {
                                return serachOfItem(pattern);
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: InkWell(child: Text(suggestion.name),
                                    onTap: () {
                                      List<ItemData> listSearchItem = [];
                                      listSearchItem =
                                          menudetailitem.allItemsDetail ?? [];
                                      ItemData itemForSearch = new ItemData();
                                      itemForSearch.id = suggestion.id;
                                      itemForSearch.itemName = suggestion.name;
                                      itemForSearch.rate = suggestion.rate;

                                      listSearchItem.add(itemForSearch);

                                      menudetailitem.addOrder(listSearchItem);
                                    },
                                  ),
                                );
                              },
                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
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
                          child:savekotsMen==false? FutureBuilder<List<KotMenu>>(
                              future: getmenutabblesOfKot(),
                              builder: (context, snapshot) {
                                try {
                                  if (snapshot.hasData) {
                                    final usa = snapshot.data;

                                      kotsMenu=usa;
                                    return ListView.builder(
                                      controller: new ScrollController(
                                          keepScrollOffset: false),
                                      //scrollDirection: Axis.horizontal,
                                      itemCount: usa == null ? 0 : usa.length,


                                      itemBuilder:
                                          (BuildContext context, int indexs) {
                                        final menus = usa[indexs];
                                        usa.forEach((name) {
                                          expansionState.putIfAbsent(indexs, () => true);
                                        });

                                        //  save(menus.id.toString());

                                         return ExpansionPanelList(
                                          expansionCallback: (int index, bool isExpanded) async{
                                            if(!isExpanded) {
                                              s = await submenuofKot(
                                                  menus.id, indexs);
                                              setState(() {
                                                savekotsMen=true;
                                                _activeMeterIndex =
                                                _activeMeterIndex == indexs
                                                    ? null
                                                    : indexs;
                                              });
                                            }else{

                                            }
                                          },
                                          children: [
                                            ExpansionPanel(
                                              headerBuilder: (BuildContext context, bool isExpanded) {
                                                return ListTile(
                                                  title: Text(menus.name),
                                                );
                                              },
                                              body:  Container(
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



                                                    return ExpansionPanelList(
                                                      expansionCallback: (int index, bool isExpanded) async{
                                                        if(!isExpanded) {
                                                          se = await menuItemofKot(submenu.id,subMenuindex);

                                                          setState(() {
                                                            activeMeterIndex =
                                                            activeMeterIndex == indexs
                                                                ? null
                                                                : indexs;
                                                          });
                                                        }else{

                                                        }
                                                      },
                                                      children: [
                                                        ExpansionPanel(
                                                          headerBuilder: (BuildContext context, bool isExpanded) {
                                                            return ListTile(
                                                              title: Text(submenu.name),
                                                            );
                                                          },
                                                          body:  Container(
                                                            //    color: Colors.pink,
                                                            width: 40 * Config.blockSizeVertical,
                                                            height: 300,
                                                            child:ListView
                                                                .builder(
                                                              controller:
                                                              new ScrollController(keepScrollOffset: false),
                                                              //scrollDirection: Axis.horizontal,
                                                              itemCount: se == null ? 0 : se.length,

                                                              itemBuilder: (BuildContext context, int subMenuindex) {
                                                                final menuItems = se[subMenuindex];



                                                                return InkWell(
                                                                  onTap: () async {


                                                                  },
                                                                  child: Text(menuItems.name),
                                                                );
                                                              },
                                                            )
                                                            ,
                                                          ),
                                                          isExpanded: activeMeterIndex == indexs,
                                                        )
                                                      ],
                                                    );
                                                  },
                                                )
                                                ,
                                              ),
                                              isExpanded: _activeMeterIndex == indexs,
                                            )
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

                                return Center(
                                    child: CircularProgressIndicator());
                              }):
                          Container(
                            height: 60 * Config.blockSizeVertical,
                            child: ListView.builder(
                              controller: new ScrollController(
                                  keepScrollOffset: false),
                              //scrollDirection: Axis.horizontal,
                              itemCount: kotsMenu == null ? 0 : kotsMenu.length,


                              itemBuilder:
                                  (BuildContext context, int indexs) {
                                final menus = kotsMenu[indexs];
                                kotsMenu.forEach((name) {
                                  expansionState.putIfAbsent(indexs, () => true);
                                });

                                //  save(menus.id.toString());

                                return ExpansionPanelList(
                                  expansionCallback: (int index, bool isExpanded) async{
                                    if(!isExpanded) {
                                      s = await submenuofKot(
                                          menus.id, indexs);
                                      setState(() {
                                        savekotsMen=true;
                                        _activeMeterIndex =
                                        _activeMeterIndex == indexs
                                            ? null
                                            : indexs;
                                      });
                                    }else{
                                        setState(() {
                                          _activeMeterIndex=-1;
                                        });
                                    }
                                  },
                                  children: [
                                    ExpansionPanel(
                                      headerBuilder: (BuildContext context, bool isExpanded) {
                                        return ListTile(
                                          title: Text(menus.name),
                                        );
                                      },
                                      body:  Container(
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



                                            return ExpansionPanelList(
                                              expansionCallback: (int index, bool isExpandeds) async{
                                                if(!isExpandeds) {

                                                  se = await menuItemofKot(submenu.id,subMenuindex);
                                                    
                                                  setState(() {
                                                    activeMeterIndex =
                                                    activeMeterIndex == subMenuindex
                                                        ? null
                                                        : subMenuindex;
                                                  });
                                                }else{
                                                      setState(() {
                                                        activeMeterIndex=-1;
                                                      });
                                                }
                                              },
                                              children: [
                                                ExpansionPanel(
                                                  headerBuilder: (BuildContext context, bool isExpanded) {
                                                    return ListTile(
                                                      title: Text(submenu.name),
                                                    );
                                                  },
                                                  body:  Container(
                                                    //    color: Colors.pink,
                                                    width: 40 * Config.blockSizeVertical,
                                                    height: 300,
                                                    child:ListView
                                                        .builder(
                                                      controller:
                                                      new ScrollController(keepScrollOffset: false),
                                                      //scrollDirection: Axis.horizontal,
                                                      itemCount: se == null ? 0 : se.length,

                                                      itemBuilder: (BuildContext context, int subMenuindex) {
                                                        final menuItems = se[subMenuindex];



                                                        return InkWell(
                                                          onTap: () async {
                                                            this.subMenuListItemIdofKots=menuItems.id;
                                                            final List<ItemData> user =await  getallItemsDetailsOfKot( this.subMenuListItemIdofKots);
                                                            if(user.isNotEmpty){

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
                                                          child: Container(height:30,margin: EdgeInsets.only(left: 15),child: Text(menuItems.name)),
                                                        );
                                                      },
                                                    )
                                                    ,
                                                  ),
                                                  isExpanded: activeMeterIndex == subMenuindex,
                                                )
                                              ],
                                            );
                                          },
                                        )
                                        ,
                                      ),
                                      isExpanded: _activeMeterIndex == indexs,
                                    )
                                  ],
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
            ),
          );
        });
      });
    }
  }
}


