import 'package:restaurant/modal/GetItemDetail.dart';
import 'package:rxdart/rxdart.dart';

class MenuDetailItem{
  final BehaviorSubject<List<ItemData>> _controller = BehaviorSubject<List<ItemData>>();
  Function(List<ItemData> itemdata) get addOrder => _controller.sink.add;


  List<ItemData> get allItemsDetail => _controller.value;
  Stream<List<ItemData>> get orderitemStream => _controller.stream;


  final BehaviorSubject<Map<int,List<ItemData>>> itemModifiercontroller= BehaviorSubject<Map<int,List<ItemData>>>();
  Function(Map<int,List<ItemData>> items) get additemModifierdata => itemModifiercontroller.sink.add;
  Map<int,List<ItemData>> get allItemsModifierDetail => itemModifiercontroller.value ?? {};
  Stream<Map<int,List<ItemData>>> get orderitemStreams => itemModifiercontroller.stream;

  @override
  void dispose() async {


  allItemsDetail.clear();
   // itemModifiercontroller.close();

  }

}

final menudetailitem=MenuDetailItem();
