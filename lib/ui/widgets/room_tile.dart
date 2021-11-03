import 'package:chatim/models/room_model.dart';
import 'package:flutter/material.dart';

class RoomTile extends StatelessWidget {
  final RoomModel room;
  const RoomTile({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(5),
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
              Icon(
                Icons.check_circle,
                size: 13,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
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
