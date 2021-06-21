import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:restaurant/Services/getBotMenuServices.dart';
import 'package:restaurant/Services/searchItemServices.dart';
import 'package:restaurant/modal/getBotMenu.dart';
import 'package:restaurant/modal/getSearchModal.dart';
import 'package:restaurant/ui/Bill.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/ReactiveData/MenuDetailItem.dart';
import 'package:restaurant/Services/GetItemDetailServices.dart';
import 'package:restaurant/Services/GetMenuItemService.dart';

import 'package:restaurant/Services/GetMenuService.dart';
import 'package:restaurant/Services/GetSubMenuServices.dart';
import 'package:restaurant/modal/GetItem.dart';
import 'package:restaurant/modal/GetItemDetail.dart';
import 'package:restaurant/modal/GetMenu.dart';
import 'package:restaurant/modal/GetSubMenu.dart';
import 'package:restaurant/ui/Bill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Check.dart';
import '../size_config.dart';
import 'Home.dart';
import 'Login.dart';
import 'OrderList.dart';

class Bots extends StatefulWidget{
  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Bots> {
  int _selectedIndex = 0;
  bool expands=false;
  bool expandss=false;
  int selected = -1;
  int selecte = -1;
  int MenuListItemOfBots;

  //int _selectedIndex = 0;
  bool sun;
  bool i=false;
  bool kotMenuList=false;
  bool mun;
  int kotSelected = -1;
  bool isexpand=false;
  List<SubMenuDetail> submenus=[];
  List<BotMenu> kotMenu=[];
  int isexpandformenu;
  int kotSubMenuSelected = 0;
  int kotMenuItemSelected = 0;
  int subMenuListItemIdofKots;
  String menuParamter = "KOT";
  List<SubMenuDetail> sub=[];

  int _currentIndex = 0;
  List<ItemData> mos = [];

  Future<List<ItemData>> GetBotItems(int subMenuListItemOfBots) async {
    try {

      return await GetItemDetailServices().getall(subMenuListItemOfBots);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }
  TextEditingController searchItemNamesController = new TextEditingController();
  Future<List<SearchItem>> serachOfItem(String searchItemName) async {
    try {

      return await searchItemServices().searchItem(searchItemName);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  List<BotMenu> kotsMenu=[];
  bool savekotsMen=false;





  Future<List<BotMenu>> getbotmenutabbles() async {

    try {


      return await getBotMenuServices().getBotMenus();
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  Future<List<SubMenuDetail>> submenu(int botMenuId,int index) async {
    try {
      ;
      return await GetSubMenuServices().getalls(botMenuId,index);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }

  Future<List<MenuItem>> menuItem(int botSubMenuId,int index) async {
    try {

      return await GetMenuItemServices().getalls(botSubMenuId,index);
    } catch (SocketExcpetion) {
      print(SocketExcpetion);
    }
  }
  List<SubMenuDetail> s;
  List<MenuItem> se;
  int _activeMeterIndex=-1;
  int activeMeterIndex=-1;

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
            body: Row(
              children: <Widget>[
                Container(
                  width: 100*Config.blockSizeHorizental,
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
                        height:200,
                        //color: Colors.blue,
                        child: ListView.builder(

                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index)=>Entry(data[index])

                        ),
                      ),

                    ],
                  ),
                ),
                Expanded(child: MyAppss())
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
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //

                  Container(
                    width: 100 * Config.blockSizeHorizental,
                    height: 80 * Config.blockSizeVertical,
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
                                        BorderRadius.circular(10))),
                              ),
                              suggestionsCallback: (pattern) {
                                return serachOfItem(pattern);
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: InkWell(child: Text(suggestion.name),
                                    onTap: (){
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
                          child:savekotsMen==false? FutureBuilder<List<BotMenu>>(
                              future:getbotmenutabbles(),
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
                                        final menuListOfBot = usa[indexs];


                                        //  save(menus.id.toString());

                                        return ExpansionPanelList(
                                          expansionCallback: (int index, bool isExpanded) async{
                                            if(!isExpanded) {
                                              s = await submenu(menuListOfBot.id,indexs);
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
                                                  title: Text(menuListOfBot.name),
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
                                                          se = await menuItem(submenu.id,subMenuindex);

                                                          setState(() {
                                                            activeMeterIndex =
                                                            activeMeterIndex == subMenuindex
                                                                ? null
                                                                : subMenuindex;
                                                          });
                                                        }else{

                                                        }
                                                      },
                                                      children: [
                                                        ExpansionPanel(
                                                          headerBuilder: (BuildContext context, bool isExpandeds) {
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


                                //  save(menus.id.toString());

                                return ExpansionPanelList(
                                  expansionCallback: (int index, bool isExpanded) async{
                                    if(!isExpanded) {
                                      s = await submenu(menus.id,indexs);
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

                                                  se = await menuItem(submenu.id,subMenuindex);

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
                                                  headerBuilder: (BuildContext context, bool isExpandeds) {
                                                    return ListTile(
                                                      title: Text(submenu.name),
                                                    );
                                                  },
                                                  body:  Container(
                                                    //    color: Colors.pink,

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
                                                            final List<ItemData> user =await  GetBotItems( this.subMenuListItemIdofKots);
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
                                                          child: Container(margin:EdgeInsets.only(left: 15),height: 30,child: Text(menuItems.name)),
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
