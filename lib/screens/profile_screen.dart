import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_on_hand/apis/apis.dart';
import 'package:doctors_on_hand/screens/login_screen.dart';
import 'package:doctors_on_hand/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Position newPosition;
  // Function to upload image to Firebase Storage
  Future<String?> uploadImageToFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    final picker = ImagePicker();

    // Pick an image from the gallery
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Create a reference to the user's profile image in Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${user!.uid}.jpg');

      // Upload the image file to Firebase Storage
      final uploadTask = storageRef.putFile(File(pickedImage.path));

      // Get the download URL of the uploaded image
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Return the download URL
      return downloadUrl;
    }

    return null;
  }

  final picker = ImagePicker();

  Future<File?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final storage = FirebaseStorage.instance;
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference reference =
          storage.ref().child('profile_pictures/$fileName');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() => null);
      final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  late File _imageFile;

  Future<void> _selectAndUploadImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });

      final downloadUrl = await uploadImage(_imageFile);
      if (downloadUrl != null) {
        // Save the download URL to the user's profile or database
        // e.g., Firestore, Realtime Database, etc.
        // Your code here...
      }
    }
  }

  Future<void> logout() async {
    try {
      await APIs.auth.signOut();
      // Logout successful

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      print('Logout successful');
    } catch (e) {
      // Handle logout error
      print('Logout error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? username = APIs.auth.currentUser?.displayName;
  String? email = APIs.auth.currentUser?.email;

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(81, 168, 255, 60),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(34),
              bottomRight: Radius.circular(34),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    _selectAndUploadImage();
                  },
                  child: const Stack(children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            AssetImage('assets/images/doctor1.png'),
                      ),
                    ),
                    Positioned(
                      bottom: -0.05,
                      left: 80,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                    )
                  ]),
                ),
                const SizedBox(height: 10),
                Text(
                  '${username?.toUpperCase()}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$email',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 170,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            children: [
              Profile_Menu(
                title: 'Update Location',
                icon: Icons.location_city,
                onPress: () async {
                  try {
                    await _getCurrentLocation();
                    updateLocation(newPosition);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Location Updated'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    print('error $e');
                  }
                },
              ),
              const Divider(),
              Profile_Menu(
                title: 'Logout',
                icon: Icons.logout,
                onPress: () {
                  logout();
                },
                textcolor: Colors.red,
                endicon: false,
              ),
            ],
          ),
        )
      ],
    );
  }

  void updateProfile() {}

  void updateLocation(Position position) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('doctors')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'location': GeoPoint(current_location_lat, current_location_long)
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      current_location_lat = position.latitude;
      current_location_long = position.longitude;
      newPosition = position;
    } catch (e) {
      print("Error getting location: $e");

      // Handle any error that occurred while obtaining the location.
    }
  }
}

// Widget updateProfilePopup() {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController Controller = TextEditingController();
//
//   return AlertDialog(
//     title: Text('Popup'),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         InkWell(
//           //  onTap: _pickImage,
//           child: CircleAvatar(
//             radius: 50,
//             // backgroundImage: _selectedImage != null
//             //     ? FileImage(File(_selectedImage!))
//             //     : null,
//             // child: _selectedImage == null ? Icon(Icons.add_a_photo) : null,
//           ),
//         ),
//         SizedBox(height: 16),
//         TextField(
//           controller: nameController,
//           decoration: InputDecoration(labelText: 'Field 1'),
//         ),
//       ],
//     ),
//     actions: [
//       ElevatedButton(
//         onPressed: () {
//           // Save button logic
//           String value1 = _textFieldController1.text;
//           String value2 = _textFieldController2.text;
//           print('Field 1: $value1');
//           print('Field 2: $value2');
//           Navigator.of(context).pop(); // Close the popup
//         },
//         child: Text('Save'),
//       ),
//     ],
//   );
// }

class Profile_Menu extends StatelessWidget {
  const Profile_Menu({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endicon = true,
    this.textcolor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endicon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.cyan.withOpacity(0.2),
        ),
        child: Icon(
          icon,
          color: const Color.fromRGBO(81, 168, 255, 60),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Poppins', color: Colors.black)
            ?.apply(color: textcolor),
      ),
      trailing: endicon
          ? Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.cyan.withOpacity(0.2),
              ),
              child: const Icon(Icons.arrow_forward_ios_outlined,
                  color: Colors.blueGrey),
            )
          : null,
    );
  }
}
