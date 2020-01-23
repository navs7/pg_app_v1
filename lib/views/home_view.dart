import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pg_app_v1/models/pg_meals.dart';

class HomeView extends StatelessWidget {
  final List<PgMeals> _mealList = [
    PgMeals(DateTime.now(), "Breakfast", "Not have", "Will have", "Single omlet", "Double omlet", "Nav", "Nav2", "Nav3", "Nav4", 4, 12, 5, 7),
    PgMeals(DateTime.now(), "Lunch", "Not have", "Will have", "Single omlet", "Double omlet", "Nav", "Nav2", "Nav3", "Nav4", 3, 12, 8, 2),
    PgMeals(DateTime.now(), "Dinner", "Not have", "Will have", "Single omlet", "Double omlet", "Nav", "Nav2", "Nav3", "Nav4", 5, 22, 1, 9),
  ];
  //var dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.parse("2019-09-30"));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      child: new ListView.builder(
          itemCount: _mealList.length,
          itemBuilder: (BuildContext context, int index) =>
              buildDateCard(context, index)),
    );
  }

  Widget buildDateCard(BuildContext context, int index) {
    final meals = _mealList[index];
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                        DateFormat("dd-MM-yyyy").format(meals.myDate).toString(),
                        style: TextStyle(fontSize: 20.0),),
                        Spacer(),
                        Text(meals.mealTime, style: TextStyle(fontSize: 20.0),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 2.0),
                child: Row(
                  children: <Widget>[
                    Text(meals.mealChoice1),
                    Spacer(),
                    Text(meals.totalCount1.toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:2.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(meals.userNames1),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 2.0),
                child: Row(
                  children: <Widget>[
                    Text(meals.mealChoice2),
                    Spacer(),
                    Text(meals.totalCount2.toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:2.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(meals.userNames2),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 2.0),
                child: Row(
                  children: <Widget>[
                    Text(meals.mealChoice3),
                    Spacer(),
                    Text(meals.totalCount3.toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:2.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(meals.userNames3),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 2.0),
                child: Row(
                  children: <Widget>[
                    Text(meals.mealChoice4),
                    Spacer(),
                    Text(meals.totalCount4.toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:2.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(meals.userNames4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
