class SocialUtils {
  static Uri getInstagramUrl(String username) =>
      Uri.parse("https://instagram.com/$username/");
  static Uri getSnapchatUrl(String username) =>
      Uri.parse("https://www.snapchat.com/add/$username/");
}
