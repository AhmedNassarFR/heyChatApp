import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message, senderId, senderEmail, receiverId;
  final Timestamp timestamp;

  MessageModel({required this.receiverId,
    required this.senderEmail,
    required this.message,
    required this.senderId,
    required this.timestamp});


  Map <String, dynamic> toMap() {
    return {
      'senderID': senderId,
      'senderEmail': senderEmail,
      'receiverID': receiverId,
      'message': message,
      'timestamp':timestamp
    };
  }


}
