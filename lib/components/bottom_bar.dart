import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        height: 50,
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: IterateWidget,
        ),
      ),
    );
  }
}

get IterateWidget => List.generate(
    4,
    (index) => Tab(
          icon: Icon(
            Icons.home,
            size: 18,
          ),
          child: Text(
            '홈',
            style: TextStyle(fontSize: 9),
          ),
        ));
