import 'package:flame/core/common/enums/gender_enum.dart';

class Utils {
  static int extractGenderIdFromEnum(Gender gender) {
    return gender.index + 1;
  }
}
