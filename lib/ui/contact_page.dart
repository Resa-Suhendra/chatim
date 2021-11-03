import 'package:chatim/services/contact_service.dart';
import 'package:chatim/ui/widgets/contact_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Contact List"),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: StreamBuilder(
          stream: ContactService.contactList("4HwIh1k3egflwVE94dAcSg7OCUa2"),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return ContactTile(email: doc['email'], name: doc['name']);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
