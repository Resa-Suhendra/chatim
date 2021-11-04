import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chatim/models/message_model.dart';
import 'package:chatim/models/person_model.dart';
import 'package:chatim/services/message_service.dart';
import 'package:chatim/services/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final PersonModel receiver;

  const ChatPage({Key? key, required this.receiver}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(receiver);
}

class _ChatPageState extends State<ChatPage> {
  final PersonModel receiver;

  _ChatPageState(this.receiver);

  final TextEditingController _messageController = TextEditingController();
  ScrollController scroll = ScrollController();

  PersonModel? sender;

  @override
  void initState() {
    super.initState();
    setSession();
  }

  setSession() async {
    var s = await Shared.getPersonFromSession();

    setState(() {
      sender = s;
    });
  }

  onTapSend() {
    MessageModel mess = MessageModel(
      dateTime: DateTime.now(),
      type: 'text',
      uidSender: sender!.uid,
      uidReceiver: receiver.uid,
      message: _messageController.text,
    );
    MessageService.sendMessage(mess, sender!, receiver).then((value) {
      scroll.jumpTo(scroll.position.maxScrollExtent);
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: Text(receiver.name ?? "No Name"),
    );

    Widget chats = StreamBuilder(
      stream: MessageService.messagesList(sender!.uid!, receiver.uid!),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data!.size < 1) {
            return const Center(child: Text("Belum ada pesan"));
          } else {
            return Scrollbar(
              child: ListView(
                controller: scroll,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: snapshot.data!.docs
                    .map((doc) => BubbleNormal(
                        text: doc['message'],
                        color: doc['uidSender']
                                .toString()
                                .contains("${sender!.uid}")
                            ? Colors.green
                            : Colors.white,
                        tail: false,
                        isSender: doc['uidSender']
                                .toString()
                                .contains("${sender!.uid}")
                            ? true
                            : false))
                    .toList(),
              ),
            );
          }
        }
      },
    );


    Widget inputMessage = Container(
      color: Colors.grey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  maxWidth: MediaQuery.of(context).size.width,
                  minHeight: 20.0,
                  maxHeight: 135.0,
                ),
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
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: onTapSend,
              child: const CircleAvatar(
                backgroundColor: Colors.green,
                radius: 20,
                child: Center(child: Icon(Icons.send_rounded)),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: appbar,
      body: Container(
        padding: const EdgeInsets.only(bottom: 60),
        child: chats,
      ),
      bottomSheet: inputMessage,
    );
  }
}
