

import 'package:doctors_on_hand/models/DocorModel.dart';
import 'package:flutter/material.dart';

import '../../utils/size_utils.dart';


//card to represent a single user in home screen
class ChatUserCard extends StatefulWidget {
final DoctorModel doctor;
  const ChatUserCard({super.key, required this.doctor});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {

  //last message info (if null --> no message)




  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.04, vertical: 4),
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: (){},
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text('${widget.doctor.name}'),
          subtitle: Text('${widget.doctor.email}'),
          trailing: Text('8:00pm'),



        ),
      ),

    );
  }
}


