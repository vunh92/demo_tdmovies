import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      constraints: const BoxConstraints.expand(),
      color: Colors.orangeAccent,
      child: const Text('Search', style: TextStyle(color: Colors.white, fontSize: 30),),
    );
    return Container(
      child: Text('Search'),
    );
  }
}
