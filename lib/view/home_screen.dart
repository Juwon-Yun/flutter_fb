import 'package:flutter/material.dart';
import 'package:flutter_fb/components/circle_slider.dart';
import 'package:flutter_fb/model/movie_model.dart';
import 'package:flutter_fb/components/box_slider.dart';
import 'package:flutter_fb/components/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_1.png',
      'like': true
    }),
    Movie.fromMap({
      'title': '매트릭스',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_2.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '조커',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_3.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '블랙 위도우',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_4.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '1917',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_5.png',
      'like': false
    }),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: ListView(children: [
        Stack(
          children: [
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        CircleSlider(movies: movies),
        BoxSlider(movies: movies),
      ]),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/bbongflix_logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
