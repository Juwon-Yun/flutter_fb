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
      debugShowCheckedModeBanner: false,
      title: 'YunFlix',
      theme: ThemeData(
        // darkTheme working, you need to remove the brightness parameter
        // brightness: Brightness.dark,
        primaryColor: Colors.black,

        // accentColor is deprecated
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),
      ),
      home: SafeArea(
        top: false,
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  child: Center(
                    child: Text('home'),
                  ),
                ),
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
                  child: Center(
                    child: Text('more'),
                  ),
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
