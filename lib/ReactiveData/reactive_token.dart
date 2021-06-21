import 'package:rxdart/rxdart.dart';

class _ReactiveToken {
  final BehaviorSubject<String> _tokenSubject = BehaviorSubject();
  String get token => _tokenSubject.value;

  Function(String val) get addToken => _tokenSubject.sink.add;

void dispose(){
  _tokenSubject.close();
}

}
final reactiveToken = _ReactiveToken();
