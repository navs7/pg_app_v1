import 'package:flutter/material.dart';
import 'package:pg_app_v1/services/auth_service.dart';
import 'package:pg_app_v1/views/home_view.dart';
import 'package:pg_app_v1/views/widgets/provider_widge.dart';
import 'package:pg_app_v1/pages.dart';
import 'package:pg_app_v1/views/user_input.dart';
import 'package:pg_app_v1/models/pg_meals.dart';

  final bgColor = const Color(0xffe53935);//FF75A2EA);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final userInput = new PgMeals(null, null, null, null, null, null, null,
        null, null, null, null, null, null, null);
    return Scaffold(
      appBar: AppBar(
        title: Text("PG app"),
        backgroundColor: bgColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInput(
                            pgMeals: userInput,
                          )));
            },
          ),
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              try{
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed out");
              }catch(e){
                print(e);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () async {
              Navigator.of(context).pushNamed('/convertUser');
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.home), title: new Text("Home")),
            BottomNavigationBarItem(
                icon: new Icon(Icons.history), title: new Text("History"))
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
