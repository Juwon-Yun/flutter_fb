import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb/model/movie_model.dart';
import 'package:flutter_fb/view/detail_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;

  const CarouselImage({Key? key, required this.movies}) : super(key: key);

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<bool> likes;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    likes = widget.movies.map((e) => e.like).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider(
            items: widget.movies.map((e) => Image.network(e.poster)).toList(),
            options: CarouselOptions(onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
              });
            }),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              widget.movies[_currentPage].keyword,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      likes[_currentPage]
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                });
                              },
                              icon: Icon(Icons.check))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                });
                              },
                              icon: Icon(Icons.add)),
                      Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text(
                          '재생',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                movie: widget.movies[_currentPage],
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.info),
                      ),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes.length, _currentPage),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(int length, int curPage) => List.generate(
      length,
      (index) => Container(
        width: 8,
        height: 8,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: curPage == index
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4),
        ),
      ),
    );
