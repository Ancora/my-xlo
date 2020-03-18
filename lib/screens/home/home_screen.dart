import 'package:flutter/material.dart';
import 'package:myxlo/common/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My XLO'),
      ),
      drawer: CustomDrawer(),
    );
  }
}
