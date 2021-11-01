import 'package:chatim/models/person_model.dart';
import 'package:chatim/services/person_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatim/extension/firebase_user_ext.dart';
import 'package:flutter/material.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign-up ke firebase authentication dengan email dan password
  static Future<SignInSignUpResult> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      /// membuat akun ke auth firebase app
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      PersonModel person = result.user!.convertToPerson(
        uid: result.user!.uid,
        name: name,
        email: email,
        password: password,
      );

      /// update data ke firestore untuk add data Person
      await PersonServices.updatePerson(person);

      return SignInSignUpResult(message: result.user!.email);
    } catch (e) {
      print("### Error nih gan : " + e.toString());
      return SignInSignUpResult(message: e.toString());
    }
  }

  /// Sign-in ke firebase dengan email dan password
  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      /// login ke firebase
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      debugPrint(result.user.toString());

      /// get data 'Person' dari firestore
      PersonModel person = await result.user!.fromFireStore();

      return SignInSignUpResult(personModel: person, message: person.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return SignInSignUpResult(message: e.message);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

}

class SignInSignUpResult {
  PersonModel? personModel;
  String? message;

  SignInSignUpResult({this.personModel, this.message});
}
