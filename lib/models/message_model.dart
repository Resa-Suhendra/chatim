class MessageModel {
  DateTime? dateTime;
  bool? isRead;
  String? message;
  String? type;
  String? uidSender;
  String? uidReceiver;

  MessageModel({
    required this.dateTime,
    required this. type,
    required this.uidSender,
    required this.uidReceiver,
    required this.message
  });

  
}
