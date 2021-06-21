import 'package:rxdart/rxdart.dart';

class _ReactiveUrlSetting {
  final BehaviorSubject<String> UrlSubject = BehaviorSubject();
  String get Url => UrlSubject.value;

  Function(String val) get addurl => UrlSubject.sink.add;

  void dispose(){
    UrlSubject.close();
  }

}
final reactiveUrl = _ReactiveUrlSetting();
