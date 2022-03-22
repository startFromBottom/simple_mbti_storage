import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_mbti_store/model/chatting_rooms.dart';
import 'package:simple_mbti_store/repository/chatting_repository.dart';

class ChattingService extends ChangeNotifier {
  final chattingRepository = ChattingRepository();

  void createChattingRoom(String myId, String yourId, String createdAt) {
    chattingRepository
        .createChattingRoom(ChattingRoom.getInstance(myId, yourId, createdAt));
    notifyListeners();
  }

  void writeMessageInChattingRoom(String chattingRoomId, Message message) {
    chattingRepository.writeMessageInChattingRoom(chattingRoomId, message);
    notifyListeners();
  }

  Stream<QuerySnapshot<Object?>>? readMessagesStream(String chattingRoomId) {
    return chattingRepository.readMessagesStream(chattingRoomId);
  }

  Future<QuerySnapshot<Object?>>? readChattingRooms(String myId) {
    return chattingRepository.readChattingRooms(myId);
  }

  void deleteChattingRoom(String chattingRoomId) async {
    chattingRepository.deleteChattingRoom(chattingRoomId);
    notifyListeners();
  }
}
