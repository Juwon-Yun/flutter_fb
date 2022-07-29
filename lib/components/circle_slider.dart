import 'package:flutter/material.dart';
import 'package:flutter_fb/model/movie_model.dart';
import 'package:flutter_fb/view/detail_screen.dart';

class CircleSlider extends StatelessWidget {
  final List<Movie> movies;

  const CircleSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('미리보기'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeCircleImages(movies, context),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(List<Movie> movies, BuildContext context) =>
    List.generate(
      movies.length,
      (index) => InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DetailScreen(movie: movies[index])));
        },
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/${movies[index].poster}'),
              radius: 48,
            ),
          ),
        ),
      ),
    );
