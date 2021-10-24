import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({Key key}) : super(key: key);

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      constraints: const BoxConstraints.expand(),
      color: Colors.deepPurple,
      child: const Text('My List', style: TextStyle(color: Colors.white, fontSize: 30),),
    );
  }
}
