import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;
  final DocumentReference reference;

  Movie.fromMap(Map<dynamic, dynamic> map, {required this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'] == 'true' ? true : false;

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<dynamic, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "Movie<$title:$keyword>";
}
