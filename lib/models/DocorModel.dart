import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  String speciality;
  String name;
  String bio;
  double cnic;
  String id;
  String pushToken;
  String email;
  List<String> otherSpecialities;
  String regCode;
  String image;
  GeoPoint location;

  DoctorModel(
      {required this.speciality,
      required this.name,
      required this.bio,
      required this.cnic,
      required this.image,
      required this.id,
      required this.pushToken,
      required this.email,
      required this.otherSpecialities,
      required this.regCode,
      required this.location});

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
        location: json["location"],
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
        "location": location,
      };

  // Factory method to create a Doctor object from a Firestore DocumentSnapshot
  factory DoctorModel.fromSnapshot(DocumentSnapshot snapshot) {
    return DoctorModel(
      id: snapshot.id,
      name: snapshot['name'] as String,
      speciality: snapshot['speciality'] as String,
      bio: snapshot['bio'],
      cnic: snapshot['cnic'],
      email: snapshot['email'],
      image: '',
      pushToken: snapshot['push_token'],
      otherSpecialities: [],
      regCode: '',
      location: snapshot['location'],
      // Initialize other properties as needed
    );
  }
}
