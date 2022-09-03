import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb/components/bottom_bar.dart';
import 'package:flutter_fb/firebase_options.dart';
import 'package:flutter_fb/view/home_screen.dart';
import 'package:flutter_fb/view/like_screen.dart';
import 'package:flutter_fb/view/more_screen.dart';
import 'package:flutter_fb/view/search_screen.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var logger = Logger();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  logger.d('fcmToken ::: $fcmToken');

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const FirebaseExample());
}

class FirebaseExample extends StatefulWidget {
  const FirebaseExample({Key? key}) : super(key: key);

  @override
  State<FirebaseExample> createState() => _FirebaseExampleState();
}

class _FirebaseExampleState extends State<FirebaseExample> {
  // TabController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BbongFlix',
      theme: ThemeData(
        // darkTheme working, you need to remove the brightness parameter
        brightness: Brightness.dark,
        primaryColor: Colors.black,

        // accentColor is deprecated
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   secondary: Colors.white,
        // ),
      ),
      home: SafeArea(
        top: false,
        child: DefaultTabController(
          // default duration value : 0.2sec
          animationDuration: Duration(milliseconds: 300),
          length: 4,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                SearchScreen(),
                LikeScreen(),
                MoreScreen(),
              ],
            ),
            bottomNavigationBar: BottomBar(),
          ),
        ),
      ),
    );
  }
}
