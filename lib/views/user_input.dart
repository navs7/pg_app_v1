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
  
  //save & retrieve DATE
  public void storeDatetoFirebase() {
    handler = new Handler();
    runnable = new Runnable() {
        @Override
        public void run() {
            handler.postDelayed(this, 1000);
            try {
                Date date = new Date();
                Date newDate = new Date(date.getTime() + (604800000L * 2) + (24 * 60 * 60));
                SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
                String stringdate = dt.format(newDate);

                System.out.println("Submission Date: " + stringdate);
                DatabaseReference databaseReference = FirebaseDatabase.getInstance().getReference().child("My_Date");
                databaseReference.child("init_date").setValue(stringdate);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    };
    handler.postDelayed(runnable, 1 * 1000);
    //not in this function
    double _timeOfDayToDouble(TimeOfDay tod) => tod.hour + tod.minute/60.0;
    var now = _timeOfDayToDouble(TimeOfDay.now());
    var startTime = _timeOfDayToDouble(_startTime);  // _startTime is a TimeOfDay
    var stopTime = _timeOfDayToDouble(_stopTime);    // _stopTime is a TimeOfDay
    if (now > startTime && now < stopTime) {
    // do your work here ...
    }
    //not in this function
    var now = DateTime.now();
    var berlinWallFell = DateTime.utc(1989, 11, 9);
    var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
    berlinWallFell.compareTo(berlinWallFell); // => 0 (equal)
    moonLanding.compareTo(berlinWallFell); // => -1 (not equal)

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
