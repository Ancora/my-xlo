import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myxlo/blocs/drawer_bloc.dart';
import 'package:myxlo/screens/create/create_screen.dart';
import 'package:myxlo/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController _pageController = PageController();

  DrawerBloc _drawerBloc;
  StreamSubscription _drawerSubscription;

  // pegar o BLoc quando usamos StateFull:
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final DrawerBloc drawerBloc = Provider.of<DrawerBloc>(context);
    if (drawerBloc != _drawerBloc) {
      _drawerBloc = drawerBloc;

      _drawerSubscription?.cancel();
      _drawerSubscription = _drawerBloc.outPage.listen((page) {
        try {
          _pageController.jumpToPage(page);
        } catch (e) {}
      });
    }
  }

  @override
  void dispose() {
    _drawerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(),
          CreateScreen(),
          Container(color: Colors.green),
          Container(color: Colors.grey),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}
