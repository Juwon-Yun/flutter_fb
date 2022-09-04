import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_fb/main.dart';

class PushManager {
  static final PushManager _manager = PushManager._internal();

  PushManager();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  PushManager._internal();

  void _requestIOSPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: true,
    );

    logger.d("승인 단계 ::: ${settings.authorizationStatus}");

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      logger.d("foreground 에서 메세지가 도착했어요 ::: ${event.data}");

      if (event.notification != null) {
        logger.d("event 가 메세지랑 알람도 가지고 있어요 ::: ${event.notification}");
      }
    });
  }

  void registerToken() async {
    if (Platform.isIOS) {
      _requestIOSPermission();
      final fcmToken = await FirebaseMessaging.instance.getToken();
      logger.d('기기 토큰 ::: $fcmToken');
    }
  }

  void listenBackgroundMessaging() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    logger.d("백그라운드 메세지 ::: ${message.messageId}");
  }
}
