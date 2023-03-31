import 'package:get/get_utils/src/extensions/internacionalization.dart';

/// DateFormat.
enum DateFormat {
  DEFAULT, //yyyy-MM-dd HH:mm:ss.SSS
  NORMAL, //yyyy-MM-dd HH:mm:ss
  YEAR_MONTH_DAY_HOUR_MINUTE, //yyyy-MM-dd HH:mm
  YEAR_MONTH_DAY, //yyyy-MM-dd
  YEAR_MONTH, //yyyy-MM
  MONTH_DAY, //MM-dd
  MONTH_DAY_HOUR_MINUTE, //MM-dd HH:mm
  HOUR_MINUTE_SECOND, //HH:mm:ss
  HOUR_MINUTE, //HH:mm
}

/// Some common formats are referenced. You can customize the format, for example: "yyyy/MM/dd HH:mm:ss"，"yyyy/M/d HH:mm:ss".
/// Format requirement
/// year -> yyyy/yy   month -> MM/M    day -> dd/d
/// hour -> HH/H      minute -> mm/m   second -> ss/s
class DataFormats {
  static String full = "yyyy-MM-dd HH:mm:ss";
  static String yyyyMMddHHmm = "yyyy-MM-dd HH:mm";
  static String yyyyMMdd = "yyyy-MM-dd";
  static String yyyyMM = "yyyy-MM";
  static String mmDD = "MM-dd";
  static String mmDDHHmm = "MM-dd HH:mm";
  static String mmDDhhMMss = "MM-dd HH:mm:ss";
  static String hhMMss = "HH:mm:ss";
  static String hhMM = "HH:mm";
  static String ddMMhhMMss = "dd-MM HH:mm:ss";
  static String ddMMyyyyHHmm = "dd-MM-yyyy HH:mm";
  static String ddMMyyyyHHmmSS = "dd-MM-yyyy HH:mm:ss";
  static String ddMMyyyy = "dd-MM-yyyy";
  static String yyyy = "yyyy";
  static String MMMMyyyy = "MM-yyyy";
}

/// month->days.
const Map<int, int> MONTH_DAY = {
  1: 31,
  2: 28,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
};

class DateUtil {
  static DateUtil instance = new DateUtil();

  /// get DateTime By DateStr.
  static DateTime? getDateTime(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = DateTime.tryParse(dateStr);
    if (isUtc != null) {
      if (isUtc) {
        dateTime = dateTime?.toUtc();
      } else {
        dateTime = dateTime?.toLocal();
      }
    }
    return dateTime;
  }

  /// get DateTime By Milliseconds.
  static DateTime getDateTimeByMs(int ms, {bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
  }

  /// get DateMilliseconds By DateStr.
  static int? getDateMsByTimeStr(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = getDateTime(dateStr, isUtc: isUtc);
    return dateTime?.millisecondsSinceEpoch;
  }

  /// get Now Date Milliseconds.
  static int getNowDateMs() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// get Now Date Str.(yyyy-MM-dd HH:mm:ss)
  static String getNowDateStr() {
    return formatDate(DateTime.now());
  }

  /// get DateStr By DateStr.
  /// dateStr         date String.
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  static String? getDateStrByTimeStr(
    String dateStr, {
    DateFormat format = DateFormat.NORMAL,
    String? dateSeparate,
    String? timeSeparate,
    bool? isUtc,
  }) {
    return getDateStrByDateTime(getDateTime(dateStr, isUtc: isUtc),
        format: format, dateSeparate: dateSeparate, timeSeparate: timeSeparate);
  }

  /// get DateStr By Milliseconds.
  /// milliseconds    milliseconds.
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  static String? getDateStrByMs(int milliseconds,
      {DateFormat format = DateFormat.NORMAL,
      String? dateSeparate,
      String? timeSeparate,
      bool isUtc = false}) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getDateStrByDateTime(dateTime,
        format: format, dateSeparate: dateSeparate, timeSeparate: timeSeparate);
  }

  /// get DateStr By DateTime.
  /// dateTime        dateTime.
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  static String? getDateStrByDateTime(DateTime? dateTime,
      {DateFormat format = DateFormat.NORMAL,
      String? dateSeparate,
      String? timeSeparate}) {
    if (dateTime == null) return null;
    String dateStr = dateTime.toString();
    dateStr = formatDateTime(dateStr, format, dateSeparate, timeSeparate);

    return dateStr;
  }

  /// format DateTime.
  /// time            time string.
  /// format          DateFormat type.
  /// dateSeparate    date separate.
  /// timeSeparate    time separate.
  static String formatDateTime(String time, DateFormat format,
      String? dateSeparate, String? timeSeparate) {
    switch (format) {
      case DateFormat.NORMAL: //yyyy-MM-dd HH:mm:ss
        time = time.substring(0, "yyyy-MM-dd HH:mm:ss".length);
        break;
      case DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE: //yyyy-MM-dd HH:mm
        time = time.substring(0, "yyyy-MM-dd HH:mm".length);
        break;
      case DateFormat.YEAR_MONTH_DAY: //yyyy-MM-dd
        time = time.substring(0, "yyyy-MM-dd".length);
        break;
      case DateFormat.YEAR_MONTH: //yyyy-MM
        time = time.substring(0, "yyyy-MM".length);
        break;
      case DateFormat.MONTH_DAY: //MM-dd
        time = time.substring("yyyy-".length, "yyyy-MM-dd".length);
        break;
      case DateFormat.MONTH_DAY_HOUR_MINUTE: //MM-dd HH:mm
        time = time.substring("yyyy-".length, "yyyy-MM-dd HH:mm".length);
        break;
      case DateFormat.HOUR_MINUTE_SECOND: //HH:mm:ss
        time =
            time.substring("yyyy-MM-dd ".length, "yyyy-MM-dd HH:mm:ss".length);
        break;
      case DateFormat.HOUR_MINUTE: //HH:mm
        time = time.substring("yyyy-MM-dd ".length, "yyyy-MM-dd HH:mm".length);
        break;
      default:
        break;
    }
    time = dateTimeSeparate(time, dateSeparate, timeSeparate);
    return time;
  }

  /// date Time Separate.
  static String dateTimeSeparate(
      String time, String? dateSeparate, String? timeSeparate) {
    if (dateSeparate != null) {
      time = time.replaceAll("-", dateSeparate);
    }
    if (timeSeparate != null) {
      time = time.replaceAll(":", timeSeparate);
    }
    return time;
  }

  /// format date by milliseconds.
  /// milliseconds
  static String formatDateMs(int milliseconds,
      {bool isUtc = false, String? format}) {
    return formatDate(getDateTimeByMs(milliseconds, isUtc: isUtc),
        format: format);
  }

  /// format date by date str.
  /// dateStr
  static String formatDateStr(String dateStr, {bool? isUtc, String? format}) {
    return formatDate(getDateTime(dateStr, isUtc: isUtc), format: format);
  }

  /// format date by DateTime.
  /// year -> yyyy/yy   month -> MM/M    day -> dd/d
  /// hour -> HH/H      minute -> mm/m   second -> ss/s
  static String formatDate(DateTime? dateTime, {bool? isUtc, String? format}) {
    if (dateTime == null) return "";
    format = format ?? DataFormats.full;
    if (format.contains("yy")) {
      String year = dateTime.year.toString();
      if (format.contains("yyyy")) {
        format = format.replaceAll("yyyy", year);
      } else {
        format = format.replaceAll(
            "yy", year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  /// com format.
  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }

  /// get WeekDay By Milliseconds.
  static String getWeekDayByMs(int milliseconds, {bool isUtc = false}) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getWeekDay(dateTime);
  }

  /// get WeekDay.
  static String getWeekDay(DateTime? dateTime,
      {String languageCode = 'en', bool short = false}) {
    if (dateTime == null) return "";
    String weekday = "";
    switch (dateTime.weekday) {
      case 1:
        weekday = languageCode == 'zh' ? '星期一' : 'Monday';
        break;
      case 2:
        weekday = languageCode == 'zh' ? '星期二' : 'Tuesday';
        break;
      case 3:
        weekday = languageCode == 'zh' ? '星期三' : 'Wednesday';
        break;
      case 4:
        weekday = languageCode == 'zh' ? '星期四' : 'Thursday';
        break;
      case 5:
        weekday = languageCode == 'zh' ? '星期五' : 'Friday';
        break;
      case 6:
        weekday = languageCode == 'zh' ? '星期六' : 'Saturday';
        break;
      case 7:
        weekday = languageCode == 'zh' ? '星期日' : 'Sunday';
        break;
      default:
        break;
    }
    return languageCode == 'zh'
        ? (short ? weekday.replaceAll('星期', '周') : weekday)
        : weekday.substring(0, short ? 3 : weekday.length);
  }

  /// Return whether it is leap year.
  static bool isLeapYearByDateTime(DateTime dateTime) {
    return isLeapYearByYear(dateTime.year);
  }

  /// Return whether it is leap year.
  static bool isLeapYearByYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  /// is yesterday by millis.
  static bool isYesterdayByMillis(int millis, int locMillis) {
    return isYesterday(DateTime.fromMillisecondsSinceEpoch(millis),
        DateTime.fromMillisecondsSinceEpoch(locMillis));
  }

  /// is yesterday by dateTime.
  static bool isYesterday(DateTime dateTime, DateTime locDateTime) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay = getDayOfYear(locDateTime) - getDayOfYear(dateTime);
      return spDay == 1;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  /// get day of year.
  static int getDayOfYearByMillis(int millis, {bool isUtc = false}) {
    return getDayOfYear(
        DateTime.fromMillisecondsSinceEpoch(millis, isUtc: isUtc));
  }

  /// get day of year.
  static int getDayOfYear(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int days = dateTime.day;
    for (int i = 1; i < month; i++) {
      days = days + MONTH_DAY[i]!;
    }
    if (isLeapYearByYear(year) && month > 2) {
      days = days + 1;
    }
    return days;
  }

  /// year is equal.
  static bool yearIsEqualByMillis(int millis, int locMillis) {
    return yearIsEqual(DateTime.fromMillisecondsSinceEpoch(millis),
        DateTime.fromMillisecondsSinceEpoch(locMillis));
  }

  /// year is equal.
  static bool yearIsEqual(DateTime dateTime, DateTime locDateTime) {
    return dateTime.year == locDateTime.year;
  }

  /// is today.
  static bool isToday(int? milliseconds, {bool isUtc = false, int? locMs}) {
    if (milliseconds == null || milliseconds == 0) return false;
    DateTime old =
        DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    DateTime now;
    if (locMs != null) {
      now = DateUtil.getDateTimeByMs(locMs);
    } else {
      now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    }
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }

  /// is Week.
  static bool isWeek(int milliseconds, {bool isUtc = false}) {
    if (milliseconds <= 0) {
      return false;
    }
    DateTime _old =
        DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    DateTime _now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    DateTime old =
        _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _old : _now;
    DateTime now =
        _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _now : _old;
    return (now.weekday >= old.weekday) &&
        (now.millisecondsSinceEpoch - old.millisecondsSinceEpoch <=
            7 * 24 * 60 * 60 * 1000);
  }

  static nextMonth(DateTime now) {
    return DateTime(now.year, now.month + 1);
  }

  static int getWeekendDays(DateTime startDate, DateTime endDate) {
    int nbDays = 0;
    DateTime currentDay = startDate;
    while (currentDay.isBefore(endDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (currentDay.weekday == DateTime.saturday ||
          currentDay.weekday == DateTime.sunday) {
        nbDays += 1;
      }
    }
    return nbDays;
  }

  static milliSecondToHour(int millisecondsSinceEpoch) {
    return millisecondsSinceEpoch ~/ 3600000;
  }

  static milliSecondToMinute(int millisecondsSinceEpoch) {
    return millisecondsSinceEpoch ~/ 60000 % 60;
  }

  static milliSecondToSecond(int millisecondsSinceEpoch) {
    return millisecondsSinceEpoch ~/ 1000 -
        (milliSecondToHour(millisecondsSinceEpoch) * 60 * 60) -
        milliSecondToMinute(millisecondsSinceEpoch) * 60;
  }

  static milliSecondToTotalSecond(int millisecondsSinceEpoch) {
    return millisecondsSinceEpoch ~/ 1000;
  }

  static String formatTime(int time) {
    return time < 10 ? '0$time' : time.toString();
  }

  static String countingTime(int startTime, int endTime) {
    var counter = endTime - startTime;
    int milliToHour = DateUtil.milliSecondToHour(counter);
    int milliToMinute = DateUtil.milliSecondToMinute(counter);
    int milliToSecond = DateUtil.milliSecondToSecond(counter);
    final h = milliToHour < 10 ? '0$milliToHour' : milliToHour.toString();
    final m = milliToMinute < 10 ? '0$milliToMinute' : milliToMinute.toString();
    final s = milliToSecond < 10 ? '0$milliToSecond' : milliToSecond.toString();

    return '$h : $m : $s';
  }

  static getPercentComplete(int currentTime, int startTime, int endTime) {
    return ((currentTime - startTime) / (endTime - startTime) * 100).toInt();
  }

  static DateTime removeTimeInMonth(DateTime dateTime) {
    return dateTime.subtract(Duration(
      days: dateTime.day - 1,
      hours: dateTime.hour,
      minutes: dateTime.minute,
      seconds: dateTime.second,
      milliseconds: dateTime.millisecond,
      microseconds: dateTime.microsecond,
    ));
  }

  static DateTime removeTimeInWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(
      days: dateTime.weekday,
      hours: dateTime.hour,
      minutes: dateTime.minute,
      seconds: dateTime.second,
      milliseconds: dateTime.millisecond,
      microseconds: dateTime.microsecond,
    ));
  }

  static DateTime removeTimeInDate(DateTime dateTime) {
    return dateTime.subtract(Duration(
      hours: dateTime.hour,
      minutes: dateTime.minute,
      seconds: dateTime.second,
      milliseconds: dateTime.millisecond,
      microseconds: dateTime.microsecond,
    ));
  }

  static DateTime removeTimeInHour(DateTime dateTime) {
    return dateTime.subtract(Duration(
      minutes: dateTime.minute,
      seconds: dateTime.second,
      milliseconds: dateTime.millisecond,
      microseconds: dateTime.microsecond,
    ));
  }

  static DateTime removeTimeInMinute(DateTime dateTime) {
    return dateTime.subtract(Duration(
      seconds: dateTime.second,
      milliseconds: dateTime.millisecond,
      microseconds: dateTime.microsecond,
    ));
  }

  static int daysInMonth(final int monthNum, final int year) {
    var monthLength = new List<int>.filled(12, 0, growable: false);
    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[4] = 31;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[9] = 31;
    monthLength[11] = 31;
    monthLength[3] = 30;
    monthLength[8] = 30;
    monthLength[5] = 30;
    monthLength[10] = 30;

    if (isLeapYearByYear(year) == true)
      monthLength[1] = 29;
    else
      monthLength[1] = 28;

    return monthLength[monthNum - 1];
  }

  static String timeAgoSinceDate(DateTime dateString, {bool numericDates = true}) {
    // DateTime notificationDate = DateFormat("dd-MM-yyyy h:mma").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(dateString);

    if (difference.inDays > 8) {
      return DateUtil.formatDate(dateString, format: DataFormats.ddMMyyyy);
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1_week_ago'.tr : 'Last week';
    } else if (difference.inDays >= 2) {
      return 'day_ago'.trArgs(['${difference.inDays}']);
    } else if (difference.inDays >= 1) {
      return (numericDates) ? 'day_ago'.trArgs(['${difference.inDays}']) : 'yesterday'.tr;
    } else if (difference.inHours >= 2) {
      return'hour_ago'.trArgs(['${difference.inHours}']);
    } else if (difference.inHours >= 1) {
      return 'hour_ago'.trArgs(['${difference.inHours}']);
    } else if (difference.inMinutes >= 1) {
      return 'min_app'.trArgs(['${difference.inMinutes}']);
    } else if (difference.inSeconds >= 3) {
      return 'second_ago'.trArgs(['${difference.inMinutes}']);
    } else {
      return 'just_now'.tr;
    }
  }
}
