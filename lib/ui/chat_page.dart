import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chatim/models/message_model.dart';
import 'package:chatim/services/message_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  ScrollController scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: const Text("Chat Page"),
    );

    Widget messageField = Flexible(
      child: Container(
        color: Colors.green.withOpacity(0.2),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            maxWidth: MediaQuery.of(context).size.width,
            minHeight: 25.0,
            maxHeight: 135.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Scrollbar(
                    child: TextField(
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _messageController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            top: 2.0, left: 13.0, right: 13.0, bottom: 2.0),
                        hintText: "Type your message",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  color: Colors.green,
                  onPressed: () {
                    MessageModel mess = MessageModel(
                      dateTime: DateTime.now(),
                      type: 'text',
                      uidSender: "4HwIh1k3egflwVE94dAcSg7OCUa2",
                      uidReceiver: "ube6jwRGArYVkKANYyKjhM6O7P43",
                      message: _messageController.text,
                    );
                    MessageService.sendMessage(
                        mess, "4HwIh1k3egflwVE94dAcSg7OCUa2");
                    _messageController.clear();
                    scroll.jumpTo(scroll.position.maxScrollExtent);
                  },
                  icon: const Icon(Icons.send))
            ],
          ),
        ),
      ),
    );

    Widget chats = StreamBuilder(
      stream: MessageService.messagesList(
          "4HwIh1k3egflwVE94dAcSg7OCUa2", "ube6jwRGArYVkKANYyKjhM6O7P43"),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data!.size < 1) {
            return const Center(child: Text("Belum ada pesan"));
          } else {
            return ListView(
              controller: scroll,
              children: snapshot.data!.docs
                  .map((doc) => BubbleNormal(
                        text: doc['message'],
                        tail: true,
                        isSender:
                            doc['uidSender'] == "4HwIh1k3egflwVE94dAcSg7OCUa2"
                                ? true
                                : false,
                      ))
                  .toList(),
            );
          }
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: appbar,
      body: Container(
        padding: EdgeInsets.only(bottom: 50),
        child: chats,
      ),
      bottomSheet: messageField,
    );
  }
}
