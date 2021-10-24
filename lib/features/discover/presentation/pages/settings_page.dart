import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      constraints: const BoxConstraints.expand(),
      color: Colors.green,
      child: const Text('Settings', style: TextStyle(color: Colors.white, fontSize: 30),),
    );
    return Container(
      child: Text('Settings'),
    );
  }
}
