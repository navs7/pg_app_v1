import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pg_app_v1/models/pg_meals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/provider_widge.dart';

class UserInput extends StatefulWidget {
  final PgMeals pgMeals;
  UserInput({Key key, @required this.pgMeals}) : super(key: key);

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final PgMeals pgMeals = new PgMeals(null, null, null, null, null, null);
  int _groupValue = -1;
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal input"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat("dd-MM-yyyy").format(DateTime.now()).toString(),
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("Breakfast"),//**************?Logic to fetch from daytime?**************** */
            ),
            _myRadioButton(
              title: "Not have",
              value: 0,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
            _myRadioButton(
              title: "Will have",
              value: 1,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
            _myRadioButton(
              title: "Single Omlet",
              value: 2,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
            _myRadioButton(
              title: "Double Omlet",
              value: 3,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () async{
                pgMeals.mealType = _groupValue.toString();
                pgMeals.myDate = DateTime.now();
                pgMeals.mealTime = "Breakfast";
                pgMeals.isTakingMeal = true;
                pgMeals.addonDoubleOmlet = _groupValue.toString();
                pgMeals.addonSingleOmlet = _groupValue.toString();
                print("");
                //save data to firebase
                final uid = await Provider.of(context).auth.getCurrentUID();
                await db.collection("userData").document(uid).collection("pg_meal").add(pgMeals.toJSON());
                //clear all pages and jump to first page
                Navigator.of(context).popUntil((route)=>route.isFirst);
              },              
            )
          ],
        ),
      ),
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}
