import 'package:flutter/material.dart';


class ChatCard extends StatefulWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: InkWell(
        onTap: (){
          
        },
        child: ListTile(
          title: Text('name'),
          subtitle: Text('last message', maxLines: 1,),
          trailing: Text('12:00 am',style: TextStyle(color: Colors.black54),),
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),

        ),
      ),
    );
  }
}
