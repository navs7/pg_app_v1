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
  final PgMeals pgMeals = new PgMeals(null, null, null, null, null, null, null);
  int _groupValue = -1;
  String _radioValue;
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {    
    final _mealTime = _mealTimeDisplay().first;
    final _mealDate = _mealTimeDisplay().last;
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
              child: Text(_mealDate,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(_mealTime),
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
              onChanged: (newValue){
                setState(() {
                  _groupValue = newValue;
                  _radioValue = "Single Omlet";                  
                });
              }// => setState(() => _groupValue = newValue),
            ),
            _myRadioButton(
              title: "Double Omlet",
              value: 3,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: () async{
                var now = new DateTime.now();
                //var myDate = new DateFormat("dd-MM-yyyy").format(now); // => 21-04-2019 02:40:25
                var myTime = new DateFormat("hh:mm:ss").format(now);

                pgMeals.myDate = _mealDate;
                pgMeals.myTime = myTime;
                pgMeals.mealTime = _mealTime;
                pgMeals.isTakingMeal = true;
                pgMeals.mealType = "Non-veg";
                pgMeals.addonSingleOmlet = _radioValue.toString();
                pgMeals.addonDoubleOmlet = _groupValue.toString();
                
                //save data to firebase
                final uid = await Provider.of(context).auth.getCurrentUID();
                await db.collection("userData").document(uid).collection("pg_meal").add(pgMeals.toJSON());
                //db.collection("userData").document(uid).collection("pg_meal").orderBy(myDate);
                //clear all pages and jump to first page
                Navigator.of(context).popUntil((route)=>route.isFirst);
              },              
            )
          ],
        ),
      ),
    );
  }
  //Mealtime logic
  List _mealTimeDisplay(){
    var listOut = new List();
    //listOut.removeRange(0, 1);

    var now = new DateTime.now().hour;
    var date = new DateTime.now();
    if(now >= 9 && now <=12){
      listOut.add("Lunch");
      listOut.add(DateFormat("dd-MM-yyyy").format(DateTime.now()).toString());
    }
    else if(now >=12 && now <=19){
      listOut.add("Dinner");
      listOut.add(DateFormat("dd-MM-yyyy").format(DateTime.now()).toString());      
    }
    else if(now >=19 && now <=24){
      listOut.add("Breakfast");
      var newDate = new DateTime(date.year, date.month, date.day+1);
      listOut.add(DateFormat("dd-MM-yyyy").format(newDate).toString());
    }
    else if(now >= 0 && now <=7){
      listOut.add("Breakfast");
      listOut.add(DateFormat("dd-MM-yyyy").format(DateTime.now()).toString()); 
    }
    return listOut;
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
