import 'package:restaurant/modal/GetSubMenu.dart';
import 'package:restaurant/modal/GetTotalBills.dart';
import 'package:rxdart/rxdart.dart';
import 'package:restaurant/modal/GetOpenTable.dart';

class ReactiveTotalBill{
  final BehaviorSubject<List<TotalBills>> controllerOfTotalBill = BehaviorSubject<List<TotalBills>>();
  Function(List<TotalBills> subitemdata) get addTotalBill=> controllerOfTotalBill.sink.add;


  List<TotalBills> get getTotalBillList => controllerOfTotalBill.value;
  Stream<List<TotalBills>> get TotalBillStream => controllerOfTotalBill.stream;

  @override
  void dispose() async {


    getTotalBillList.clear();
    // itemModifiercontroller.close();

  }

}
final reactiveTotalBill=ReactiveTotalBill();