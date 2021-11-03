import 'package:flutter/material.dart';

import '../chat_page.dart';

class ContactTile extends StatelessWidget {
  final String email;
  final String name;
  const ContactTile({
    Key? key,
    required this.email,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatPage()));
      },
      contentPadding: const EdgeInsets.all(5),
      tileColor: Colors.green[100],
      leading: const CircleAvatar(
        backgroundColor: Colors.amber,
        child: Icon(Icons.person),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle,
                size: 13,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(email),
              ),
            ],
          )
        ],
      ),
      trailing: Icon(Icons.chat),
    );
  }
}
