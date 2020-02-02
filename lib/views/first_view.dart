import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:pg_app_v1/views/widgets/custom_dialog.dart';

class FirstView extends StatelessWidget {
  final bgColor = const Color(0xffe53935);//FF75A2EA);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: bgColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.10),
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: _height * 0.10),
                AutoSizeText(
                  "Pick your meal choice in a single click!",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: _height * 0.30),
                RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: bgColor, fontSize: 20.0),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context)=>CustomDialog(
                        title: "Create free account",
                        description: "Lorem ipsum",
                        primaryButtonText: "Create account",
                        primaryButtonRoute: "/signUp",
                        secondaryButtonText: "Maybe later",
                        secondaryButtonRoute: "/home",
                      )
                    );
                  },
                ),
                SizedBox(height: _height * 0.08),
                FlatButton(
                  child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed('/signIn');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
