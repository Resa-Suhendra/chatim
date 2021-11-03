import 'package:chatim/services/auth_service.dart';
import 'package:chatim/services/contact_service.dart';
import 'package:chatim/ui/register_page.dart';
import 'package:chatim/ui/room_chat.dart';
import 'package:flutter/material.dart';

import 'contact_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Home Page"),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Nama Akun aktif : "),
            SizedBox(height: 20),
            Text("Email Akun aktif : "),
            SizedBox(height: 40),
            ElevatedButton(
                onPressed: _addContact, child: Text("Tambah Kontak")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ContactPage()));
                },
                child: Text("Lihat Kontak")),

            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RoomChatPage()));
                },
                child: Text("Room Chat"))
          ],
        ),
      ),
    );
  }

  void _addContact() {
    ContactService.addContact(
        "diki@xeranta.com", "4HwIh1k3egflwVE94dAcSg7OCUa2");
  }
}
