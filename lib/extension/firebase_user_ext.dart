import 'package:chatim/models/person_model.dart';
import 'package:chatim/services/person_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtension on User {
  PersonModel convertToPerson({
    required String name,
    required String email,
    required String uid,
    required String password,
  }) {
    return PersonModel(
        email: email,
        uid: uid,
        name: name,
        token: refreshToken,
        photo: '');
  }

  Future<PersonModel> fromFireStore() async =>
      await PersonServices.getPerson(uid);
}
