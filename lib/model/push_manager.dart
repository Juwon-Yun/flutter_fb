import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_fb/main.dart';

class PushManager {
  static final PushManager _manager = PushManager._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  PushManager._internal();

  void _requestIOSPermission() {
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      logger.d("Got a message in foreground ::: ${event.data}");
    });
  }
}
