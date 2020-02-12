class PgMeals{
  DateTime myDate;
  String mealTime;
  bool isTakingMeal;//will have or not
  String mealType;//veg or non-veg
  String addonSingleOmlet;
  String addonDoubleOmlet;

  PgMeals(this.myDate, this.mealTime, this.mealType, this.isTakingMeal, this.addonSingleOmlet, this.addonDoubleOmlet);

  Map<String, dynamic> toJSON() => {
    'date': myDate,
    'mealTime': mealTime,
    'isTakingMeal': isTakingMeal,
    'mealType': mealType,
    'addonSingleOmlet': addonSingleOmlet,
    'addonDoubleOmlet': addonDoubleOmlet,
  };
}
