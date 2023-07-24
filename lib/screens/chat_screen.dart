import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  final String sender;
  final String content;
  final Timestamp timestamp;

  ChatMessage({
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'content': content,
      'timestamp': timestamp,
    };
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    print('a');
    final content = _messageController.text.trim();
    _messageController.text = '';
    if (content.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not authenticated');
      return;
    }
    final message = ChatMessage(
      sender: user!.email!,
      content: content,
      timestamp: Timestamp.now(),
    );

    await FirebaseFirestore.instance
        .collection('messages')
        .add(message.toJson());
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat Screen'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  final messages = snapshot.data?.docs;
                  final messageList =
                      messages as List<DocumentSnapshot<Map<String, dynamic>>>?;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messageList?.length ?? 0,
                    itemBuilder: (context, index) {
                      final message = messageList?[index].data();
                      final content = message?['content'] as String?;
                      final sender = message?['sender'] as String?;

                      // Determine if the message is sent by the current user or received from another user
                      final isSentMessage =
                          sender == FirebaseAuth.instance.currentUser?.email;
                      print("$isSentMessage");

                      // Determine the alignment for the ListTile based on the message sender
                      final alignment = isSentMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft;

                      return Align(
                        alignment: isSentMessage
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: isSentMessage
                                ? Colors.blueAccent
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(content ?? '',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(height: 4),
                              Text(sender ?? '',
                                  style: TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
