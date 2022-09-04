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

import 'model/push_manager.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   // If you're going to use other Firebase services in the background, such as Firestore,
  //   // make sure you call `initializeApp` before using other Firebase services.
  //   await Firebase.initializeApp();
  //
  //   print("Handling a background message: ${message.messageId}");
  // }
  //
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const FirebaseExample());
}

class FirebaseExample extends StatefulWidget {
  const FirebaseExample({Key? key}) : super(key: key);

  @override
  State<FirebaseExample> createState() => _FirebaseExampleState();
}

class _FirebaseExampleState extends State<FirebaseExample> {
  // TabController controller;

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    var logger = Logger();

    logger.d('message ::: $message');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PushManager().registerToken();
    PushManager().listenBackgroundMessaging();
    setupInteractedMessage();
  }

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
