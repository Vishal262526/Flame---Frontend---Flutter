class InterestModel {
  final int id;
  final String name;

  InterestModel({
    required this.id,
    required this.name,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['id'],
      name: json['interest'],
    );
  }
}
