import 'package:chatim/models/person_model.dart';
import 'package:chatim/models/room_model.dart';
import 'package:chatim/ui/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomTile extends StatelessWidget {
  final RoomModel room;
  final bool isSender;
  const RoomTile({Key? key, required this.room, required this.isSender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String time = '';
    String minute = DateFormat('H.m').format(room.lastDateTime!);
    String date = DateFormat('dd/MM/yy').format(room.lastDateTime!);
    String tgl = DateFormat('yyyy-MM-dd').format(room.lastDateTime!);
    String skr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    DateTime a = DateTime.parse(skr);
    DateTime b = DateTime.parse(tgl);
    bool isNow = a.isAfter(b);

    time = isNow ? date : minute;

    print(a.toString() + ' <=> ' + b.toString() + " $isNow");
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
      title: Text(room.name ?? ''),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isSender
              ? const Icon(
                  Icons.check_circle,
                  size: 13,
                )
              : SizedBox(),
          Expanded(
            child: Padding(
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
          ),
        ],
      ),
      trailing: Text(time),
    );
  }
}
