import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final bool isRead;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Message(
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      message: data['message'],
      timestamp: data['timestamp'],
      isRead: data['isRead'],
    );
  }
}
