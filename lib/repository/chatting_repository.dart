import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_mbti_store/constants/firestore_constants.dart';
import 'package:simple_mbti_store/model/chatting_room_model.dart';
import 'package:simple_mbti_store/model/message_model.dart';

// TODO(hyuem) : check logic with test codes
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

  Stream<List<QuerySnapshot<Map<String, dynamic>>>> readChattingRoomsStream(
      String myId) {
    var idFromSnapshot = _chattingRoomCollection
        .where(FirestoreConstants.idFrom, isEqualTo: myId)
        .snapshots();

    var idToSnapshot = _chattingRoomCollection
        .where(FirestoreConstants.idTo, isEqualTo: myId)
        .snapshots();

    var mergedSnapshot = StreamZip([idFromSnapshot, idToSnapshot]);

    return mergedSnapshot;
  }

  // update - not supported yet.

  void deleteChattingRoom(String chattingRoomId) async {
    // 1. delete messages subcollection.
    final batch = FirebaseFirestore.instance.batch();
    final messageCollection = _chattingRoomCollection
        .doc(chattingRoomId)
        .collection(FirestoreConstants.messagesCollection);
    var snapshots = await messageCollection.get();

    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    // 2. delete ohter field.
    await _chattingRoomCollection.doc(chattingRoomId).delete();
  }
}
