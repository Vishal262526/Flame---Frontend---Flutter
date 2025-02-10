class MatchModel {
  final String uid;
  final String name;
  final String city;
  final String country;
  final List images;
  final double distance;

  MatchModel({
    required this.uid,
    required this.name,
    required this.city,
    required this.images,
    required this.distance,
    required this.country,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      images: json['images'] as List,
      city: json['city'] as String,
      country: json['country'] as String,
      distance: (json['distance'] / 1000) as double,
    );
  }

  MatchModel copyWith({
    String? uid,
    String? name,
    String? city,
    String? country,
    List? images,
    double? distance,
  }) =>
      MatchModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        images: images ?? this.images,
        city: city ?? this.city,
        country: country ?? this.country,
        distance: distance ?? this.distance,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "images": images,
        "city": city,
        "country": country,
        "distance": distance,
      };
}
