import 'dart:io';

import 'package:doctors_on_hand/apis/apis.dart';
import 'package:doctors_on_hand/screens/chat/chat_screen2.dart';
import 'package:doctors_on_hand/screens/login_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Function to upload image to Firebase Storage
  String picName = "";
  String imageUrl = '';

  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }

    _uploadImage();
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      return;
    }

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      picName = fileName;
      setState(() async {
        imageUrl = await getImageUrl();
      });
      print(picName);
      print(imageUrl);

      final reference =
          FirebaseStorage.instance.ref().child('images').child('$fileName.jpg');

      await reference.putFile(_selectedImage!);
      print('Image uploaded successfully.');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<String> getImageUrl() async {
    final storageReference =
        FirebaseStorage.instance.ref().child('images').child('${picName}');

    try {
      final imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      // Handle error, e.g., if the image doesn't exist in Firebase Storage
      print('Error getting image URL: $e');
      return '';
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
                    _pickImage();
                  },
                  child: Stack(children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: imageUrl != ''
                            ? Image.network('${imageUrl}.jpg').image
                            : AssetImage("assets/images/person.jpeg"),
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
                  child: ElevatedButton(
                    onPressed: () {
                      updateProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: BorderSide.none,
                      backgroundColor: Colors.greenAccent,
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                )
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
                title: 'Location',
                icon: Icons.location_city,
                onPress: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatHomeScreen()));
                },
              ),
              const Divider(),
              Profile_Menu(
                title: 'Information',
                icon: Icons.medical_information,
                onPress: () {},
              ),
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
