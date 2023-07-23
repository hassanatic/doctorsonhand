import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_on_hand/models/DocorModel.dart';
import 'package:doctors_on_hand/screens/chat/ChatUserCard.dart';
import 'package:flutter/material.dart';

import '../../apis/apis.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  List<DoctorModel> list = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('doctors')
                .where('id', isNotEqualTo: APIs.user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
                //if some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;

                  list = data
                          ?.map((e) => DoctorModel.fromJson(
                              e.data() as Map<String, dynamic>))
                          .toList() ??
                      [];
                  if (list.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ChatUserCard(doctor: list[index]);
                      },
                      physics: const BouncingScrollPhysics(),
                    );
                  } else
                    return Center(
                        child: Text(
                            "You have no one to talk to.\n               Sad loif"));
              }
            }),
      ),
    );
  }
}
