import 'package:chatim/models/room_model.dart';
import 'package:chatim/services/message_service.dart';
import 'package:chatim/ui/widgets/room_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomChatPage extends StatefulWidget {
  const RoomChatPage({Key? key}) : super(key: key);

  @override
  _RoomChatPageState createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text("Room Chat"),
      elevation: 0,
    );

    Widget contactButton = FloatingActionButton(
      child: const Icon(Icons.contact_phone),
      onPressed: () {},
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButton: contactButton,
      body: Container(
        child: StreamBuilder(
          stream: MessageService.roomList("4HwIh1k3egflwVE94dAcSg7OCUa2"),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              print(snapshot.data!.size.toString());
              if (snapshot.data!.size < 1) {
                return Center(
                  child:
                      Text("Belum ada teman chat, silahkan tambahkan kontak"),
                );
              } else {
                return ListView(
                  children: snapshot.data!.docs
                      .map((doc) => RoomTile(
                            room: RoomModel.fromJson({
                              'email': doc['email'],
                              'name': doc['name'],
                              'photo': doc['photo'],
                              'uid': doc['uid'],
                              'type': doc['type'],
                              'lastChat': doc['lastChat'],
                              'lastUid': doc['lastUid'],
                              'inRoom': doc['inRoom'],
                              'lastDateTime': doc['lastDateTime'].toString()
                            }),
                          ))
                      .toList(),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
