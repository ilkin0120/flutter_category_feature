abstract class TransactionType  {
  static const int expense = 0;

  static const int income = 1;

  static bool isValid(int type) {
    return type == expense || type == income;
  }

  static List<int> get allTypes => [expense, income];
}

abstract class FrequencyUnit {
  static const int day   = 0;
  static const int week  = 1;
  static const int month = 2;
  static const int year  = 3;

  static bool isValid(int value) => value >= day && value <= year;
  static List<int> get allUnits => [day, week, month, year];

  static String toText(int value) => {
    day:   'day',
    week:  'week',
    month: 'month',
    year:  'year',
  }[value] ?? 'unknown';
}

abstract class EndType {
  static const int none  = 0;
  static const int date  = 1;
  static const int count = 2;

  static bool isValid(int value) => value >= none && value <= count;
  static List<int> get allTypes => [none, date, count];
}
