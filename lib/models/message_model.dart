class MessageModel {
  DateTime? dateTime;
  bool? isRead;
  String? message;
  String? type;
  String? uidSender;
  String? uidReceiver;

  MessageModel({
    required this.dateTime,
    required this.type,
    required this.uidSender,
    required this.uidReceiver,
    required this.message
  });


  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    isRead = json['isRead'];
    message = json['message'];
    type= json['type'];
    uidSender= json['uidSender'];
    uidReceiver = json['uidReceiver'];
  }


  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime!.toIso8601String(),
      'isRead': isRead,
      'message': message,
      'type': type,
      'uidSender': uidSender,
      'uidReceiver': uidReceiver,
    };
  }
  
}
