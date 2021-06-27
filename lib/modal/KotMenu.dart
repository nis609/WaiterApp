import 'package:hive/hive.dart';
part 'KotMenu.g.dart';


@HiveType(typeId: 2)
class KotMenu {
  @HiveField(4)
  int id;
  @HiveField(5)
  String name;
  @HiveField(6)
  double rate;

  KotMenu({this.id, this.name, this.rate});

  KotMenu.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    rate = json['Rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Rate'] = this.rate;
    return data;
  }
}