import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  final String recipientUserId; // User ID of the chat recipient

  ChatScreen({required this.chatId, required this.recipientUserId});

  final _messageController = TextEditingController();

  void _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final content = _messageController.text.trim();

    if (content.isEmpty) return;

    final messageData = {
      'sender': user.uid,
      'recipient': recipientUserId,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(messageData);

      _messageController.clear();
    } catch (e) {
      // Handle errors here
      print('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('One-to-One Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data?.docs ?? [];

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (ctx, index) {
                    final message = messages[index].data() as Map<String, dynamic>;
                    final isMe = message['sender'] == FirebaseAuth.instance.currentUser?.uid;

                    return ListTile(
                      title: Text(message['content']),
                      subtitle: Text(message['sender']),
                      trailing: isMe ? Icon(Icons.check) : null,
                      // Adjust the ListTile layout based on sender or recipient
                      tileColor: isMe ? Colors.blue : Colors.grey,
                      // Change tile color based on sender or recipient
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Type a message...'),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
