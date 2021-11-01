import 'package:chatim/ui/widgets/room_tile.dart';
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
      body: ListView(
        children: [
          const RoomTile(),
        ],
      ),
    );
  }
}
