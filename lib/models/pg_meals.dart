class PgMeals{
  DateTime myDate;
  String mealTime;
  String mealChoice1;
  String mealChoice2;
  String mealChoice3;
  String mealChoice4;
  String userNames1;
  String userNames2;
  String userNames3;
  String userNames4;
  int totalCount1;
  int totalCount2;
  int totalCount3;
  int totalCount4;

  PgMeals(this.myDate, this.mealTime, this.mealChoice1, this.mealChoice2, this.mealChoice3, this.mealChoice4,
  this.userNames1, this.userNames2, this.userNames3, this.userNames4, this.totalCount1, this.totalCount2, this.totalCount3, this.totalCount4);

  Map<String, dynamic> toJSON() => {
    'date': myDate,
    'mealTime': mealTime,
    'mealChoice': mealChoice1,
    'usenName': userNames1,
    'totalCount': totalCount1,
  };
}
