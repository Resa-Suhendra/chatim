import 'dart:convert';

import 'package:chatim/models/person_model.dart';
import 'package:chatim/services/contact_service.dart';
import 'package:chatim/services/shared_prefs.dart';
import 'package:chatim/ui/widgets/contact_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  PersonModel? person;

  @override
  void initState() {
    super.initState();
    setSession();
  }

  setSession() async {
    var p = await Shared.getPersonFromSession();

    setState(() {
      person = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Contact List"),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: StreamBuilder(
          stream: ContactService.contactList(person!.uid!),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return ContactTile(
                    person: PersonModel(
                  email: doc['email'],
                  name: doc['name'],
                  token: doc['token'],
                  uid: doc['uid'],
                ));
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
