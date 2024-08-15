import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeService {
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;
  final StreamController<GyroscopeEvent> _gyroscopeController =
      StreamController<GyroscopeEvent>();

  GyroscopeService() {
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      _gyroscopeController.sink.add(event);
    });
  }

  Stream<GyroscopeEvent> get gyroscopeStream => _gyroscopeController.stream;

  void dispose() {
    _gyroscopeSubscription.cancel();
    _gyroscopeController.close();
  }
}
