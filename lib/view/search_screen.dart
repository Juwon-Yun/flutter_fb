import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb/model/movie_model.dart';
import 'package:flutter_fb/view/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = '';

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('movie').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          Future.delayed(const Duration(milliseconds: 300));

          List<DocumentSnapshot> searchResult = [];
          snapshot.data!.docs.forEach((element) {
            if (Movie.fromSnapshot(element).toString().contains(_searchText)) {
              searchResult.add(element);
            }
          });

          return GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1 / 1.5,
            padding: EdgeInsets.all(3),
            children:
                searchResult.map((e) => _buildListItem(context, e)).toList(),
          );
        });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) =>
      InkWell(
          child: Image.network(Movie.fromSnapshot(snapshot).poster),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  movie: Movie.fromSnapshot(snapshot),
                ),
              ),
            );
          });

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    style: TextStyle(fontSize: 15),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchText = '';
                            });
                          },
                          icon: Icon(
                            Icons.cancel,
                            size: 20,
                            color: Colors.white60,
                          )),
                      hintText: '검색',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // FocusScope.of(context).requestFocus(FocusNode());
              hideKeyboard(context);
            },
            child: _buildBody(context),
          )
        ],
      ),
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
