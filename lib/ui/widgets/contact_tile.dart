import 'package:chatim/models/person_model.dart';
import 'package:flutter/material.dart';

import '../chat_page.dart';

class ContactTile extends StatelessWidget {
  final PersonModel person;
  const ContactTile({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatPage(receiver: person,)));
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
          Text(person.name ?? "No Name"),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle,
                size: 13,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(person.email ?? ''),
              ),
            ],
          )
        ],
      ),
      trailing: Icon(Icons.chat),
    );
  }
}
