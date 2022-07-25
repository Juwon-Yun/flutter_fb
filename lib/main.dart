import 'package:flutter/material.dart';
import 'package:flutter_fb/components/bottom_bar.dart';

void main() {
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
      title: 'YunFlix',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,

        // accentColor is deprecated
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   secondary: Colors.white,
        // ),
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: SafeArea(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
          bottomNavigationBar: BottomBar(),
        ),
      ),
    );
  }
}
