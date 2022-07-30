import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb/components/bottom_bar.dart';
import 'package:flutter_fb/firebase_options.dart';
import 'package:flutter_fb/view/home_screen.dart';
import 'package:flutter_fb/view/more_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      title: 'YunFlix',
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
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                Container(
                  child: Center(
                    child: Text('search'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('save'),
                  ),
                ),
                Container(
                  child: MoreScreen(),
                ),
              ],
            ),
            bottomNavigationBar: BottomBar(),
          ),
        ),
      ),
    );
  }
}
