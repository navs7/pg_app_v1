import 'package:flutter/material.dart';
import 'package:pg_app_v1/views/home_view.dart';
import 'pages.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    HistoryPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PG app"),
        backgroundColor: Colors.white,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("Home")
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.history),
            title: new Text("History")
          )
        ]
      ),
    );
  }
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}