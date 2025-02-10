class FriendModel {
  final int id;
  final String uid;
  final String name;
  final String city;
  final List images;

  FriendModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.city,
    required this.images,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return FriendModel(
      id: json['id'] as int,
      uid: json['uid'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      images: json['images'] as List,
    );
  }
}
