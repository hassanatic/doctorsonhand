import 'dart:convert';

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String id;
  String pushToken;
  String email;
  String image;

  UserModel({
    required this.name,
    required this.image,
    required this.id,
    required this.pushToken,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        image: json["image"],
        id: json["id"],
        pushToken: json["push_token"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "id": id,
        "push_token": pushToken,
        "email": email,
      };
}
