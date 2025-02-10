import 'package:age_calculator/age_calculator.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static final formatDOB = DateFormat("d-MMMM-y");

  static String formatDateOfBirth(DateTime dob) => formatDOB.format(dob);

  static int calculateAge(DateTime dob) => AgeCalculator.age(dob).years;

  static String convertToActiveString(DateTime dateTime) {
    final now = DateTime.now();

    final differnece = now.difference(dateTime);

    if (differnece.inMinutes <= 5) {
      return "Active";
    } else {
      return "Recently Active";
    }
  }
}
