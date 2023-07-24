import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_on_hand/models/DocorModel.dart';
import 'package:doctors_on_hand/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static late DoctorModel me;

  static User get user => auth.currentUser!;

  static Future<bool> doctorExists() async {
    return (await firestore.collection('doctors').doc(user.uid).get()).exists;
  }

  // static Future<void> getSelfInfo()async {
  //   await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get().then((user) async {
  //     if(user.exists) {
  //       me = DoctorModel.fromJson(user.data()!);
  //     }
  //     else{
  //      await createDoctor().then((value) => getSelfInfo());
  //
  //     }
  //
  //
  //   });
  //
  //
  // }

  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  Future<int> getUserRole() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (snapshot.exists) {
      // The user document exists, so return the role
      return snapshot.get('role');
    } else {
      // Handle the case if the user document doesn't exist or the role field is not set
      // You can return a default role or an error, depending on your app's logic
      return 1;
    }
  }

  static Future<void> saveUserRole(int role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('role', role);
  }

  static Future<void> saveUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }

  // for creating a new user
  static Future<void> createDoctor(String name, String speciality, double cnic,
      String regCode, GeoPoint location) async {
    final docChatUser = DoctorModel(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      bio: "Hey! this is your personal doctor",
      image: user.photoURL.toString(),
      // createdAt: time,
      // isOnline: false,
      // lastActive: time,
      pushToken: '',
      speciality: speciality,
      cnic: cnic,
      otherSpecialities: ["dentist", "surgeon"],
      regCode: regCode,
      location: location,
    );

    return await firestore
        .collection('doctors')
        .doc(user.uid)
        .set(docChatUser.toJson());
  }

  static Future<void> createUser(String name) async {
    final chatUser = UserModel(
        id: user.uid,
        name: name,
        email: user.email.toString(),
        image: user.photoURL.toString(),
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }
}

class Api {
  String apiKey = 'AIzaSyDoFoXFgBBpQRyTcIOCjfkKvjEpGgTjacc';

  Api(this.apiKey);

  Future<List<Map<String, dynamic>>> fetchNearbyLaboratories(
      double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=10000&keyword=laboratory&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to fetch nearby laboratories');
      }
    } else {
      throw Exception('Failed to fetch nearby laboratories');
    }
  }

  Future<List<Map<String, dynamic>>> fetchNearbyHospitals(
      double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=10000&keyword=hospital&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to fetch nearby hospitals');
      }
    } else {
      throw Exception('Failed to fetch nearby hospitals');
    }
  }
}
