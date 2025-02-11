import 'package:flame/core/common/enums/gender_enum.dart';
import 'package:flame/core/utils/date_time_utils.dart';

class FriendProfileModel {
  final String uid;
  final String name;
  final Gender gender;
  final DateTime dob;
  final Gender showMeGender;
  final String state;
  final String city;
  final List interests;
  final int age;
  final List images;
  final String? snapchatUsername;
  final String? instagramUsername;
  final DateTime lastActive;

  FriendProfileModel({
    required this.uid,
    required this.name,
    required this.dob,
    required this.gender,
    required this.showMeGender,
    required this.state,
    required this.city,
    required this.interests,
    required this.age,
    required this.images,
    required this.snapchatUsername,
    required this.instagramUsername,
    required this.lastActive,
  });

  factory FriendProfileModel.fromJson(Map<String, dynamic> json) {
    return FriendProfileModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      gender: Gender.values[json['gender_id'] as int],
      dob: DateTime.parse(json['dob'] as String),
      state: json['state'] as String,
      city: json['city'] as String,
      showMeGender: Gender.values[json['show_me_gender_id'] as int],
      images: json['images'] as List,
      interests: json['interests'] as List,
      snapchatUsername: json['snapchat_username'] as String?,
      instagramUsername: json['instagram_username'] as String?,
      lastActive: DateTime.parse(json['last_active'] as String),
      age: DateTimeUtils.calculateAge(DateTime.parse(json['dob'] as String)),
    );
  }
}
