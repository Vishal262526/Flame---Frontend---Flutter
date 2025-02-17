class StringUtils {
  static String convertToCapitalize(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String getFirstName(String text) {
    final textArray = text.split(" ");

    if (textArray.length > 1) {
      return textArray[0];
    }
    return text;
  }
}
