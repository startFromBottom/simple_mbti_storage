import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_mbti_store/constants/firestore_constants.dart';
import 'package:simple_mbti_store/constants/mbti_constants.dart';

class MbtiUserInfo {
  final String uid;
  final Mbti myMbti;
  final List<Mbti> preferredMbti;

  String? selfIntroduction;

  MbtiUserInfo({
    required this.uid,
    required this.myMbti,
    required this.preferredMbti,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.uid: uid,
      FirestoreConstants.myMbti: myMbti,
      FirestoreConstants.preferredMbti: preferredMbti,
    };
  }

  factory MbtiUserInfo.fromDocument(DocumentSnapshot doc) {
    String uid = doc.get(FirestoreConstants.uid);
    Mbti myMbti = doc.get(FirestoreConstants.myMbti);
    List<Mbti> preferredMbti = doc.get(FirestoreConstants.preferredMbti);
    return MbtiUserInfo(
      uid: uid,
      myMbti: myMbti,
      preferredMbti: preferredMbti,
    );
  }
}
