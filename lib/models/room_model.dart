
class RoomModel {
  String? email;
  String? name;
  String? photo;
  String? uid;
  String? type;
  String? lastChat;
  String? lastUid;
  bool? inRoom;
  DateTime? lastDateTime;

  RoomModel({
    required this.email,
    required this.name,
    this.photo,
    required this.uid,
    required this.type,
    required this.lastChat,
    required this.lastUid,
    required this.inRoom,
    required this.lastDateTime,
  });

  RoomModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    photo = json['photo'];
    uid = json['uid'];
    type= json['type'];
    lastChat= json['lastChat'];
    lastUid = json['lastUid'];
    inRoom = json['inRoom'];
    lastDateTime = DateTime.tryParse(json['lastDateTime']);
  }


  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'photo': photo,
      'uid': uid,
      'type': type,
      'lastChat': lastChat,
      'lastUid': lastUid,
      'inRoom': inRoom,
      'lastDateTime': lastDateTime.toString(),
    };
  }
}
