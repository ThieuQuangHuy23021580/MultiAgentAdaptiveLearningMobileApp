class ProfileModel {
  final String id;

  final String name;

  final String title;

  final String avatar;

  final String email;

  final int birthYear;

  final String education;

  final int level;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.title,
    required this.avatar,
    required this.email,
    required this.birthYear,
    required this.education,
    required this.level,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      title: json["title"] ?? "",
      avatar: json["avatar"] ?? "",
      email: json["email"] ?? "",
      birthYear: json["birthYear"] ?? 0,
      education: json["education"] ?? "",
      level: json["level"] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "title": title,
      "avatar": avatar,
      "email": email,
      "birthYear": birthYear,
      "education": education,
      "level": level,
    };
  }

  ProfileModel copyWith({
    String? id,
    String? name,
    String? title,
    String? avatar,
    String? email,
    int? birthYear,
    String? education,
    int? level,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      birthYear: birthYear ?? this.birthYear,
      education: education ?? this.education,
      level: level ?? this.level,
    );
  }
}
