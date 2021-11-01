import 'package:chatim/models/person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {
  static final CollectionReference<Map<String, dynamic>> _personCollection =
      FirebaseFirestore.instance.collection('person');

  static Future<PersonModel?> addContact(String email, String personUid) async {
    final data = await _personCollection
        .where('email', isEqualTo: email)
        .get()
        .catchError((e) {
      print(e);
    });

    if (data.docs.isNotEmpty) {
      PersonModel person = PersonModel.fromJson(data.docs.single.data());
      print(person.email);

      final addContact = _personCollection
          .doc(personUid)
          .collection('contact')
          .doc(person.uid)
          .set(data.docs.single.data());
      return person;
    } else {
      print("==> Hasilnya kosong nih");
      return null;
    }
  }

  static Future<List<PersonModel>?> contactList(String uid) async {
    final data = _personCollection.doc(uid).collection('contact').snapshots();


  }
}
