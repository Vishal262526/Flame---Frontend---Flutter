import 'package:flame/core/common/enums/gender_enum.dart';
import 'package:flame/core/utils/date_time_utils.dart';

class UserModel {
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
  final DateTime lastActive;

  UserModel({
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
    required this.lastActive,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    Gender? gender,
    Gender? showMeGender,
    DateTime? dob,
    String? state,
    String? city,
    List<String>? interests,
    List<String>? images,
    DateTime? lastActive,
    int? age,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        showMeGender: showMeGender ?? this.showMeGender,
        dob: dob ?? this.dob,
        age: age ?? this.age,
        lastActive: lastActive ?? this.lastActive,
        state: state ?? this.state,
        city: city ?? this.city,
        interests: interests ?? this.interests,
        images: images ?? this.images,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      gender: Gender.values[json['gender_id'] as int],
      dob: DateTime.parse(json['dob'] as String),
      state: json['state'] as String,
      city: json['city'] as String,
      showMeGender: Gender.values[json['show_me_gender_id'] as int],
      images: json['images'] as List,
      interests: json['interests'] as List,
      lastActive: DateTime.parse((json['lastActive'] as String)),
      age: DateTimeUtils.calculateAge(DateTime.parse((json['dob'] as String))),
    );
  }
}

class CurrentUserModel {
  final String uid;
  final String name;
  final String email;
  final Gender gender;
  final DateTime dob;
  final Gender showMeGender;
  final String country;
  final String state;
  final String city;
  final List interests;
  final int age;
  final List images;
  final String? snapchatUsername;
  final String? instagramUsername;
  final DateTime lastActive;
  final int flames;

  CurrentUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.dob,
    required this.gender,
    required this.country,
    required this.showMeGender,
    required this.state,
    required this.city,
    required this.interests,
    required this.age,
    required this.images,
    required this.snapchatUsername,
    required this.instagramUsername,
    required this.lastActive,
    required this.flames,
  });

  CurrentUserModel copyWith({
    String? uid,
    String? name,
    String? email,
    Gender? gender,
    Gender? showMeGender,
    DateTime? dob,
    String? country,
    String? state,
    String? city,
    List<String>? interests,
    String? instagramUsername,
    String? snapchatUsername,
    List<String>? images,
    DateTime? lastActive,
    int? age,
    int? flames,
  }) =>
      CurrentUserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        showMeGender: showMeGender ?? this.showMeGender,
        dob: dob ?? this.dob,
        age: age ?? this.age,
        lastActive: lastActive ?? this.lastActive,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        interests: interests ?? this.interests,
        instagramUsername: instagramUsername ?? this.instagramUsername,
        snapchatUsername: snapchatUsername ?? this.snapchatUsername,
        images: images ?? this.images,
        flames: flames ?? this.flames,
      );

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      gender: Gender.values[json['gender_id'] as int],
      dob: DateTime.parse(json['dob'] as String),
      country: json['country'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      showMeGender: Gender.values[json['show_me_gender_id'] as int],
      images: json['images'] as List,
      interests: json['interests'] as List,
      snapchatUsername: json['snapchat_username'] as String?,
      instagramUsername: json['instagram_username'] as String?,
      lastActive: DateTime.parse(json['lastActive'] as String),
      age: DateTimeUtils.calculateAge(DateTime.parse(json['dob'] as String)),
      flames: json['flames'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "gender_id": gender.index,
        "dob": dob,
        "country": country,
        "state": state,
        "city": city,
        "show_me_gender_id": showMeGender.index,
        "images": images,
        "email": email,
        "interests": interests,
        "snapchat_username": snapchatUsername,
        "instagram_username": instagramUsername,
        "lastActive": lastActive.millisecondsSinceEpoch,
        "flames": flames,
      };
}
