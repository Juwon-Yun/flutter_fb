import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb/model/movie_model.dart';
import 'package:flutter_fb/view/detail_screen.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 27, 20, 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/bbongflix_logo.png',
                  fit: BoxFit.contain,
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '내가 찜한 콘텐츠',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                _buildBody(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('movie')
          .where('like', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: LinearProgressIndicator());
        }

        return _buildList(context, snapshot.data!.docs);
      });
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return GridView.count(
    crossAxisCount: 3,
    childAspectRatio: 1 / 1.5,
    padding: EdgeInsets.all(3),
    children: snapshot.map((e) => _buildListItem(context, e)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
  return InkWell(
    child: Image.network(Movie.fromSnapshot(snapshot).poster),
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute<Null>(
          fullscreenDialog: true,
          builder: (context) {
            return DetailScreen(movie: Movie.fromSnapshot(snapshot));
          },
        ),
      );
    },
  );
}
