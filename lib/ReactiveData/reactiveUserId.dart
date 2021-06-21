import 'package:rxdart/rxdart.dart';

class reactiveUserId{
  final BehaviorSubject<int> UserIdSubject = BehaviorSubject();
  int get UserId => UserIdSubject.value;

  Function(int val) get addUserId => UserIdSubject.sink.add;

  void dispose(){
    UserIdSubject.close();
  }
}
final reactiveUserID = reactiveUserId();