import 'package:intl/intl.dart';

class DateTimeUtil {
  static String dateTimeToString(DateTime dateTime, String format) {
    if (dateTime == null) return null;
    var formatter = new DateFormat(format);
    return formatter.format(dateTime);
  }

  static DateTime stringToDateTime(String dateTimeString, String format) {
    if (dateTimeString == null) return null;

    var formatter = new DateFormat(format);
    return formatter.parse(dateTimeString);
  }

  static DateTime getDateTimeLaterYear(DateTime dateTime, int value) {
    return DateTime(dateTime.year + value, dateTime.month, dateTime.day);
  }

  static DateTime getDateTimeLaterDay(DateTime dateTime, int value) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day + value);
  }

  static DateTime getDateTimeLaterMonth(DateTime dateTime, int value) {
    return DateTime(dateTime.year, dateTime.month + value, dateTime.day);
  }



  static DateTime getDateTimeServer(String dateTimeString) {
    if (dateTimeString == null) return null;

    return stringToDateTime(dateTimeString, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  }

  static String getDateTimeServerToHour(String dateTimeString) {
    if (dateTimeString == null) return "";
    var dateTime = stringToDateTime(dateTimeString, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    return dateTimeToString(dateTime, "HH:mm a");
  }

  static String getDateTimeServerToDate(String dateTimeString) {
    if (dateTimeString == null) return null;
    var dateTime = stringToDateTime(dateTimeString, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    if (dateTime == null) {
      return null;
    }
    return dateTimeToString(dateTime, "dd/MM/yyyy");
  }

  static String getDateTimeStringServer(DateTime dateTime) {
    return dateTimeToString(dateTime, "yyyy-MM-dd'T'HH:mm:ss");
  }

  static String getDateTimePayment(DateTime dateTime, {int hour = 0}) {
    dateTime = dateTime.subtract(new Duration(hours: hour));
    return dateTimeToString(dateTime, "dd/MM/yyyy' 'HH:mm");
  }

  static String getDateTimeStamp(int time) {
    if(time ==0)
      return '';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return dateTimeToString(dateTime, "dd/MM/yyyy");
  }

  static DateTime getDateTimeInTimeStamp(int time) {
    var date = DateTime.fromMillisecondsSinceEpoch(time);
    //return DateTime(date.year, date.month, date.day, date.hour, date.minute, date.second, date.millisecond);
    return date;
  }

  static String getDateTimeToDate(DateTime dateTime) {
    if (dateTime == null) return "";
    return dateTimeToString(dateTime, "yyyy-MM-dd");
  }

  static String getDateTimeToDateSub(DateTime dateTime) {
    if (dateTime == null) return "";
    return dateTimeToString(dateTime, 'dd/MM/yyyy');
  }

  static String getDateTimeToHour(DateTime dateTime) {
    if (dateTime == null) return "";
    return dateTimeToString(dateTime, 'HH:mm');
  }

  static String getDateTimeTHG(String dateTimeString) {
    if (dateTimeString == null) return "";
    if (dateTimeString.isEmpty) return "";
    var dateTime = stringToDateTime(dateTimeString, "yyyy-MM-dd'T'HH:mm:ss");
    return getFullDate(dateTime);
  }

  static String getFullDate(DateTime dateTime) {
    return dateTime.day.toString() + " thg " + dateTime.month.toString() + ", " + dateTime.year.toString();
  }

  static String getFullTime(DateTime dateTime) {
    return dateTime.hour.toString() + " : " + dateTime.minute.toString();
  }

  static String getFullDateTime(DateTime dateTime) {
    return dateTime.day.toString() + " thg " + dateTime.month.toString() + ", " + dateTime.year.toString() + ", " + dateTimeToString(dateTime, "HH:mm:ss");
  }

  static String getFullDateTimeStringServer(String dateTimeString) {
    var dateTime = getDateTimeServer(dateTimeString);

    return getFullDateTime(dateTime);
  }

  static DateTime getDateTimeStartDay(DateTime dateTime) {
    if (dateTime == null) return null;
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0, 0);
  }

  static DateTime getDateTimeEndDay(DateTime dateTime) {
    if (dateTime == null) return null;
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 0, 0);
  }

  static int getTimeStamp(DateTime dateTime) {
    if (dateTime == null) return null;
    return (dateTime.millisecondsSinceEpoch / 1000).toInt();
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    if (date1 == null && date2 == null) {
      return true;
    }
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  static int isSameOnlyHourAndMinute(DateTime date1, DateTime date2) {
    if (date1 == null && date2 == null) {
      return 0;
    }
    if (date1 == null || date2 == null) {
      return 0;
    }
    if (date1.hour > date2.hour) {
      return 1;
    }
    if (date1.hour < date2.hour) {
      return -1;
    }
    if (date1.minute > date2.minute) {
      return 1;
    }
    if (date1.minute < date2.minute) {
      return -1;
    }
    return 0;
  }

  static int compareOnlyDay(DateTime date1, DateTime date2) {
    if (date1 == null && date2 == null) {
      return 0;
    }
    if (date1 == null || date2 == null) {
      return 0;
    }
    return getDateTimeStartDay(date1).difference(getDateTimeStartDay(date2)).inDays;
  }

  static String getTimeMinuteFromSecond(int second) {
//    final duration = Duration(seconds: second);
//    var time = duration.toString().split('.').first.padLeft(8, '0').substring(3);
//    time = time.replaceAll(":0", "m");
//    time = time.replaceAll(":", "m") + "s";
//    time = time.replaceAll("m0s", "m");
//    return time;
    final duration = Duration(seconds: second);
    var seconds = duration.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}');
    }
    //if (seconds != 0) {
    tokens.add('${seconds}');
    //}
    if (tokens.length == 0) {
      tokens.add('${seconds}');
    }

    return tokens.join(':');
  }
}
