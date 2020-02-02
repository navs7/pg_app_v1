import 'package:flutter/material.dart';
import 'package:pg_app_v1/services/auth_service.dart';
import 'package:pg_app_v1/views/signup_view.dart';
import 'home_page.dart';
import 'views/first_view.dart';
import 'views/widgets/provider_widge.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
          title: 'PG_App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.teal),
          //home: Home()
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp,),
            '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn,),
            '/home': (BuildContext context) => HomeController(),
          }),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}

