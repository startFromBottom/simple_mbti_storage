import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_mbti_store/constants/firestore_constants.dart';
import 'package:simple_mbti_store/model/chatting_rooms.dart';

class ChattingRepository {
  final int _limit = 30;

  final _chattingRoomCollection = FirebaseFirestore.instance
      .collection(FirestoreConstants.chattingRoomsBucket);

  void createChattingRoom(ChattingRoom chattingRoom) async {
    DocumentReference docRef =
        _chattingRoomCollection.doc(chattingRoom.getChattingRoomId());
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(docRef, chattingRoom.toJson());
    });
  }

  void writeMessageInChattingRoom(String chattingRoomId, Message message) {
    DocumentReference docRef = _chattingRoomCollection
        .doc(chattingRoomId)
        .collection(FirestoreConstants.messagesCollection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(docRef, message.toJson());
    });
  }

  Stream<QuerySnapshot<Object?>>? readMessagesStream(String chattingRoomId) {
    return _chattingRoomCollection
        .doc(chattingRoomId)
        .collection(FirestoreConstants.messagesCollection)
        .limit(_limit)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> readChattingRooms(String myId) async {
    CollectionReference<Map<String, dynamic>> messages =
        _chattingRoomCollection.doc().collection("messages");
    var idFromQuery = await _chattingRoomCollection
        .where(FirestoreConstants.idFrom, isEqualTo: myId)
        .get();

    var idToQuery = await _chattingRoomCollection
        .where(FirestoreConstants.idTo, isEqualTo: myId)
        .get();

    idFromQuery.docs.addAll(idToQuery.docs);

    return idFromQuery;
  }

  // update - not supported yet.

  void deleteChattingRoom(String chattingRoomId) async {
    await _chattingRoomCollection.doc(chattingRoomId).delete();
  }
}
