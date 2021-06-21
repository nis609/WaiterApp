import 'package:rxdart/rxdart.dart';

class _ReactiveUsername {
  final BehaviorSubject<String> UsernameSubject = BehaviorSubject();
  String get Username => UsernameSubject.value;

  Function(String val) get addUsername => UsernameSubject.sink.add;

  void dispose(){
    UsernameSubject.close();
  }

}
final ReactiveUsername = _ReactiveUsername();
