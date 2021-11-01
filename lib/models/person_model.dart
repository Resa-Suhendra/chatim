import 'package:chatim/models/room_model.dart';

import 'message_model.dart';

class PersonModel {
  String? email;
  String? name;
  String? token;
  String? uid;
  String? photo;

  PersonModel({
    required this.email,
    required this.name,
    required this.token,
    required this.uid,
    this.photo,
  });

  factory PersonModel.fromJson(Map<String, dynamic>? json) => PersonModel(
        email: json!['email'],
        name: json['name'],
        token: json['token'],
        uid: json['uid'],
        photo: json['photo'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "token": token,
        "uid": uid,
        "photo": photo,
      };
}
