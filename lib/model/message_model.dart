import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_mbti_store/constants/firestore_constants.dart';

class Message {
  final String idFrom;
  final String idTo;
  final String content;
  final String timestamp;
  final int type;

  Message({
    required this.idFrom,
    required this.idTo,
    required this.content,
    required this.timestamp,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
    };
  }

  factory Message.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get(FirestoreConstants.idFrom);
    String idTo = doc.get(FirestoreConstants.idTo);
    String timestamp = doc.get(FirestoreConstants.timestamp);
    String content = doc.get(FirestoreConstants.content);
    int type = doc.get(FirestoreConstants.type);
    return Message(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}
