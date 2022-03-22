import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/firestore_constants.dart';

class ChattingRoom {
  final String idFrom;
  final String idTo;
  late String? _chattingRoomId;

  ChattingRoom({
    required this.idFrom,
    required this.idTo,
  });

  factory ChattingRoom.getInstance(String idFrom, String idTo) {
    return ChattingRoom(idFrom: idFrom, idTo: idTo);
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.messagesCollection: null,
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
    };
  }

  // TODO (hyuem) - is it thread safe?
  String getChattingRoomId() {
    if (_chattingRoomId != null) {
      return _chattingRoomId!;
    }
    String result;
    if (idFrom.hashCode <= idTo.hashCode) {
      result = '$idFrom-$idTo';
    } else {
      result = '$idTo-$idFrom';
    }
    _chattingRoomId = result;
    return result;
  }
}

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

class MessageType {
  static const text = 1;
  static const image = 2;
}
