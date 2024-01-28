extension DateTimeExtension on DateTime{
  //is it today
  bool get isToday{
    final now=DateTime.now();
    return now.day==day && now.month==month && now.year==year;
  }
  //is it tomorrow
  bool get isTomorrow{
    final now=DateTime.now();
    return now.day+1==day && now.month==month && now.year==year;
  }
  //is it AM 
  bool get isAM=>hour>12;
  //is it PM'
  bool get isPM=>hour<12;
  //get hour in 12 format
  int get hourIn12Format=>hour>12?hour-12:hour>0?hour:12;
  //get day name
  String get dayName{
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}