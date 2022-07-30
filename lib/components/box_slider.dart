import 'package:flutter/material.dart';
import 'package:flutter_fb/model/movie_model.dart';
import 'package:flutter_fb/view/detail_screen.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  const BoxSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('지금 뜨는 콘텐츠'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeBoxImages(movies, context),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeBoxImages(List<Movie> movies, BuildContext context) =>
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
            alignment: Alignment.centerLeft,
            child: Image.network('${movies[index].poster}'),
          ),
        ),
      ),
    );
