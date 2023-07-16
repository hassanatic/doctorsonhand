import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final VoidCallback onTap;

  ChatCard({required this.profileImageUrl, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileImageUrl),
              radius: 30,
            ),
            SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}


Future<List<ChatUserData>> fetchChatUsers() async {
  try {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('users').get();

    // Convert the documents into a list of ChatUserData
    final List<ChatUserData> chatUsers = snapshot.docs.map((doc) {
      final data = doc.data();
      return ChatUserData(
        profileImageUrl: data['profileImageUrl'],
        name: data['name'],
      );
    }).toList();

    return chatUsers;
  } catch (e) {
    // Handle any errors that may occur during the database query
    print('Error fetching chat users: $e');
    return []; // Return an empty list in case of an error
  }
}

class ChatListScreen extends StatelessWidget {
  final List<ChatUserData> chatUsers; // List of user data (Profile image URLs and names)

  ChatListScreen(this.chatUsers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List'),
      ),
      body: FutureBuilder<List<ChatUserData>>(
        future: fetchChatUsers(), // Assuming this function fetches a list of users
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching chat users'),
            );
          }

          final chatUsers = snapshot.data ?? [];

          return ListView.builder(
            itemCount: chatUsers.length,
            itemBuilder: (ctx, index) {
              return ChatCard(
                profileImageUrl: "assets/images/person.jpeg",
                name: chatUsers[index].name,
                onTap: () {
                  // Handle chat card tap here (e.g., navigate to the chat screen)
                  // You can pass the user's ID to the chat screen to open a chat with this user
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChatUserData {
  final String profileImageUrl;
  final String name;

  ChatUserData({required this.profileImageUrl, required this.name});
}