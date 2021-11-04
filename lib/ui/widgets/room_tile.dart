import 'package:chatim/models/person_model.dart';
import 'package:chatim/models/room_model.dart';
import 'package:chatim/ui/chat_page.dart';
import 'package:flutter/material.dart';

class RoomTile extends StatelessWidget {
  final RoomModel room;
  final bool isSender;
  const RoomTile({Key? key, required this.room, required this.isSender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiver: PersonModel(
                email: room.email,
                name: room.name,
                token: '',
                uid: room.uid,
              ),
            ),
          ),
        );
      },
      tileColor: Colors.green[100],
      leading: const CircleAvatar(
        backgroundColor: Colors.amber,
        child: Icon(Icons.person),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(room.name ?? ''),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isSender
                  ? Icon(
                      Icons.check_circle,
                      size: 13,
                    )
                  : SizedBox(),
              Padding(
                padding: EdgeInsets.only(
                  right: 5,
                  left: isSender ? 5 : 0,
                ),
                child: Text(
                  room.lastChat ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
      trailing: Text("19.22"),
    );
  }
}
