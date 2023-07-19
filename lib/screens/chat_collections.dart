import 'package:doctors_on_hand/reuseable_widgets/chat_card.dart';
import 'package:flutter/material.dart';

class ChatCollections extends StatefulWidget {
  const ChatCollections({Key? key}) : super(key: key);

  @override
  State<ChatCollections> createState() => _ChatCollectionsState();
}

class _ChatCollectionsState extends State<ChatCollections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
          itemCount: 1,
          itemBuilder: (context, index) {
            return ChatCard();
          }),
    );
  }
}
