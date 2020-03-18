import 'package:flutter/material.dart';
import 'package:myxlo/screens/home/home_screen.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(),
          Container(color: Colors.yellow),
          Container(color: Colors.green),
          Container(color: Colors.grey),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}
