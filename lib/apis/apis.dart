import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_on_hand/models/DocorModel.dart';
import 'package:doctors_on_hand/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<bool> doctorExists() async {
    return (await firestore.collection('doctors').doc(user.uid).get()).exists;
  }

  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> saveUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }

  // for creating a new user
  static Future<void> createDoctor() async {
    final docChatUser = DoctorModel(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        bio: "!",
        image: user.photoURL.toString(),
        // createdAt: time,
        // isOnline: false,
        // lastActive: time,
        pushToken: '',
        speciality: 'gyno',
        cnic: 3420359895771,
        otherSpecialities: ["dentist", "heart surgeon"],
        regCode: 4578);

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
