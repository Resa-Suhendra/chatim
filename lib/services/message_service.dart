import 'package:chatim/models/message_model.dart';
import 'package:chatim/models/person_model.dart';
import 'package:chatim/models/room_model.dart';
import 'package:chatim/services/person_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  static final CollectionReference<Map<String, dynamic>> _personCollection =
      FirebaseFirestore.instance.collection('person');

  static final CollectionReference<Map<String, dynamic>> _chatCollection =
      FirebaseFirestore.instance.collection('room');

  // static Future<void> sendMessageT(MessageModel message, String myUid) async {
  //   try {

  //     RoomModel(email: , name: name, uid: uid, type: type, lastChat: lastChat, lastUid: lastUid, inRoom: inRoom, lastDateTime: lastDateTime)

  //     final data = await _chatCollection
  //         .doc()
  //         .set(message.toJson()).then((value) => {
  //           _chatCollection.
  //         });
  //   } on FirebaseException catch (e) {
  //     print(e.message);
  //   }
  // }

  static Future<void> sendMessage(
      MessageModel message, String personUid) async {
    try {
      final data = await _personCollection
          .doc(personUid)
          .collection('room')
          .doc(message.uidReceiver)
          .collection('chat')
          .doc(message.dateTime!.toIso8601String())
          .set(message.toJson())
          .then((value) => {
                _personCollection
                    .doc(message.uidReceiver)
                    .collection('room')
                    .doc(personUid)
                    .collection('chat')
                    .doc(message.dateTime!.toIso8601String())
                    .set(message.toJson())
              });

      final PersonModel person = await PersonServices.getPerson(message.uidReceiver!);

      _personCollection
          .doc(personUid)
          .collection('room')
          .doc(message.uidReceiver)
          .set(RoomModel(
                  email: person.email,
                  name: person.name,
                  uid: person.uid,
                  type: message.type,
                  lastChat: message.message,
                  lastUid: message.uidSender,
                  inRoom: false,
                  lastDateTime: message.dateTime)
              .toJson());

      _personCollection
          .doc(message.uidReceiver)
          .collection('room')
          .doc(personUid)
          .set(RoomModel(
                  email: 'resa@xeranta.com',
                  name: "Resa",
                  uid: personUid,
                  type: message.type,
                  lastChat: message.message,
                  lastUid: message.uidSender,
                  inRoom: false,
                  lastDateTime: message.dateTime)
              .toJson());
    } on FirebaseException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  // static Stream<List<MessageModel>> messageListByUid(
  //     String myUid, String roomUid) async* {
  //   try {
  //     final data = _personCollection
  //         .doc(myUid)
  //         .collection('room')
  //         .doc(roomUid)
  //         .collection('chat')
  //         .snapshots()
  //         .map((QuerySnapshot list) {
  //           returnnu
  //     });

  //     yield* data;
  //   } on FirebaseException catch (e) {
  //     print(e.message);
  //   }
  // }

  static Stream<QuerySnapshot<Map<String, dynamic>>> messagesList(
      String uid, String roomUid) async* {
    try {
      final data = _personCollection
          .doc(uid)
          .collection('room')
          .doc(roomUid)
          .collection('chat')
          .snapshots();

      yield* data;
    } catch (e) {
      print(e);
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> roomList(
      String myUid) async* {
    try {
      final data = _personCollection.doc(myUid).collection('room').snapshots();

      yield* data;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
