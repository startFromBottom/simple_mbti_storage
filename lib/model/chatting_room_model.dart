import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_constants.dart';

class ChattingRoom {
  final String idFrom;
  final String idTo;
  final String createdAt;
  late String? _chattingRoomId;

  ChattingRoom({
    required this.idFrom,
    required this.idTo,
    required this.createdAt,
  });

  factory ChattingRoom.getInstance(
      String idFrom, String idTo, String createdAt) {
    return ChattingRoom(idFrom: idFrom, idTo: idTo, createdAt: createdAt);
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.chattingRoomId: _chattingRoomId,
    };
  }

  factory ChattingRoom.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get(FirestoreConstants.idFrom);
    String idTo = doc.get(FirestoreConstants.idTo);
    String createdAt = doc.get(FirestoreConstants.createdAt);
    return ChattingRoom(idFrom: idFrom, idTo: idTo, createdAt: createdAt);
  }

  // TODO(hyuem) need to check it is thread-safe.
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

class MessageType {
  static const text = 1;
  static const image = 2;
}
