import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_mbti_store/constants/firestore_constants.dart';
import 'package:simple_mbti_store/model/mbti_user_model.dart';

class MbtiUserInfoRepository {
  final int _limit = 5;

  final _mbtiUserInfoCollection = FirebaseFirestore.instance
      .collection(FirestoreConstants.mbtiUserInfoBucket);

  void createMbtiUserInfo(MbtiUserInfo mbtiUserInfo) async {
    DocumentReference docRef = _mbtiUserInfoCollection.doc(mbtiUserInfo.uid);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(docRef, mbtiUserInfo.toJson());
    });
  }

  // must get only one
  Stream<DocumentSnapshot<Map<String, dynamic>>> readMbtiUserInfoStream(
      String myId) {
    return _mbtiUserInfoCollection.doc(myId).snapshots();
  }

  Stream<QuerySnapshot<Object?>>? readRecommendedMbtiUsersStream(
      MbtiUserInfo mbtiUserInfo) {
    return _mbtiUserInfoCollection
        .where(FirestoreConstants.gender, isNotEqualTo: mbtiUserInfo.gender)
        .where(FirestoreConstants.preferredMbti,
            arrayContains: mbtiUserInfo.myMbti)
        .limit(_limit)
        .snapshots();
  }
}
