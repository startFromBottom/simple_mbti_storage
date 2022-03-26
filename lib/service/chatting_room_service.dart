import 'package:async/src/stream_zip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_mbti_store/model/chatting_room_model.dart';
import 'package:simple_mbti_store/model/message_model.dart';
import 'package:simple_mbti_store/repository/chatting_room_repository.dart';

// TODO(hyuem) : check logic with test codes
class ChattingRoomService extends ChangeNotifier {
  final _chattingRepository = ChattingRoomRepository();

  void createChattingRoom(String myId, String yourId, String createdAt) {
    _chattingRepository
        .createChattingRoom(ChattingRoom.getInstance(myId, yourId, createdAt));
    notifyListeners();
  }

  void writeMessageInChattingRoom(String chattingRoomId, Message message) {
    _chattingRepository.writeMessageInChattingRoom(chattingRoomId, message);
    notifyListeners();
  }

  Stream<QuerySnapshot<Object?>>? readMessagesStream(String chattingRoomId) {
    return _chattingRepository.readMessagesStream(chattingRoomId);
  }

  Stream<List<QuerySnapshot<Map<String, dynamic>>>> readChattingRoomsStream(
      String myId) {
    return _chattingRepository.readChattingRoomsStream(myId);
  }

  void deleteChattingRoom(String chattingRoomId) async {
    _chattingRepository.deleteChattingRoom(chattingRoomId);
    notifyListeners();
  }
}
