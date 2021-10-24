import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      constraints: const BoxConstraints.expand(),
      color: Colors.cyan,
      child: const Text('News', style: TextStyle(color: Colors.white, fontSize: 30),),
    );
    return Container(
      child: Text('News'),
    );
  }
}
