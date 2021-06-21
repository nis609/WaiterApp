
import 'package:restaurant/modal/GetItemModifier.dart';
import 'package:rxdart/rxdart.dart';


// class ItemModifiers{
//   final BehaviorSubject<List<ItemModifier>> itemModifiercontroller = BehaviorSubject<List<ItemModifier>>();
//
//   Function(List<ItemModifier> itemModifiers) get additemModifierdata => itemModifiercontroller.sink.add;
//
//   List<ItemModifier> get allItemsModifierDetail => itemModifiercontroller.value;
//   Stream<List<ItemModifier>> get orderitemStream => itemModifiercontroller.stream;
//   void dispose(){
//     itemModifiercontroller.close();
//   }
//
//
// }
//
// final itemModifier=ItemModifiers();


class ItemModifiers {
  final BehaviorSubject<Map<int,List<ItemModifier>>> itemModifiercontroller= BehaviorSubject<Map<int,List<ItemModifier>>>();
  Function(Map<int,List<ItemModifier>> items) get additemModifierdata => itemModifiercontroller.sink.add;
  Map<int,List<ItemModifier>> get allItemsModifierDetail => itemModifiercontroller.value ?? {};
  Stream<Map<int,List<ItemModifier>>> get orderitemStream => itemModifiercontroller.stream;

  void dispose () {
    itemModifiercontroller.close();
  }
}
final itemModifier  = ItemModifiers();

class ItemsModifiers{
  final BehaviorSubject<List<ItemModifier>> _controller = BehaviorSubject<List<ItemModifier>>();
  Function(List<ItemModifier> itemdata) get addOrder => _controller.sink.add;


  List<ItemModifier> get allItemsDetail => _controller.value;
  Stream<List<ItemModifier>> get orderitemStream => _controller.stream;
  void dispose(){
    _controller.close();
  }
}

final itemModifiers=ItemsModifiers();

