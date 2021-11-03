import 'package:chatim/models/person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonServices {
  static final CollectionReference<Map<String, dynamic>> _personCollection =
      FirebaseFirestore.instance.collection('person');

  static Future<void> updatePerson(PersonModel profileModel) async {
    _personCollection.doc(profileModel.uid).set({
      'email': profileModel.email,
      'name': profileModel.name,
      'photo': profileModel.photo,
      'token': profileModel.token
    });
  }

  static Future<PersonModel> getPerson(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _personCollection.doc(uid).get();
    return PersonModel.fromJson(snapshot.data());
  }

}
