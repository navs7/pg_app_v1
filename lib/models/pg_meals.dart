class PgMeals{
  int order;
  String myDate;
  String myTime;
  String mealTime;
  bool isTakingMeal;//will have or not
  String mealType;//veg or non-veg
  String addonSingleOmlet;
  String addonDoubleOmlet;

  PgMeals(this.order, this.myDate, this.myTime, this.mealTime, this.mealType, this.isTakingMeal, this.addonSingleOmlet, this.addonDoubleOmlet);

  Map<String, dynamic> toJSON() => {
    'order': order,
    'myDate': myDate,
    'myTime': myTime,
    'mealTime': mealTime,
    'isTakingMeal': isTakingMeal,
    'mealType': mealType,
    'addonSingleOmlet': addonSingleOmlet,
    'addonDoubleOmlet': addonDoubleOmlet,
  };
}
