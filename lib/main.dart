import 'package:flutter/material.dart';

void main() {
  runApp(const FirebaseExample());
}

class FirebaseExample extends StatefulWidget {
  const FirebaseExample({Key? key}) : super(key: key);

  @override
  State<FirebaseExample> createState() => _FirebaseExampleState();
}

class _FirebaseExampleState extends State<FirebaseExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YunFlix',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,

        // accentColor is deprecated
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),
      ),
      home: const DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [],
          ),
        ),
      ),
    );
  }
}
