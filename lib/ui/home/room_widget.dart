import 'package:chat/model/room.dart';
import 'package:chat/ui/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context)
            .pushNamed(ChatScreen.routeName,
        arguments: room
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0,3),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: Image.asset('assets/images/${room.catId}.png',
              width: MediaQuery.of(context).size.width*.3,
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(room.title)
          ],
        ),
      ),
    );
  }
}
