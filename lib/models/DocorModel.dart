import 'dart:convert';

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  String speciality;
  String name;
  String bio;
  int cnic;
  String id;
  String pushToken;
  String email;
  List<String> otherSpecialities;
  int regCode;
  String image;

  DoctorModel({
    required this.speciality,
    required this.name,
    required this.bio,
    required this.cnic,
    required this.image,
    required this.id,
    required this.pushToken,
    required this.email,
    required this.otherSpecialities,
    required this.regCode,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        speciality: json["speciality"],
        name: json["name"],
        bio: json["bio"],
        image: json["image"],
        cnic: json["cnic"],
        id: json["id"],
        pushToken: json["push_token"],
        email: json["email"],
        otherSpecialities:
            List<String>.from(json["other_specialities"].map((x) => x)),
        regCode: json["reg_code"],
      );

  Map<String, dynamic> toJson() => {
        "speciality": speciality,
        "name": name,
        "bio": bio,
        "image": image,
        "cnic": cnic,
        "id": id,
        "push_token": pushToken,
        "email": email,
        "other_specialities":
            List<dynamic>.from(otherSpecialities.map((x) => x)),
        "reg_code": regCode,
      };
}
