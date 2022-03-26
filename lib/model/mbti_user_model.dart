import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_mbti_store/constants/firestore_constants.dart';
import 'package:simple_mbti_store/constants/gender.dart';
import 'package:simple_mbti_store/constants/mbti_constants.dart';

class MbtiUserInfo {
  // key between Firebase user and MbtiUserInfo bucket.
  final String uid;
  final String nickname;
  final Gender gender;
  final Mbti myMbti;
  final List<Mbti> preferredMbti;

  String? selfIntroduction;

  MbtiUserInfo({
    required this.uid,
    required this.nickname,
    required this.gender,
    required this.myMbti,
    required this.preferredMbti,
    required this.selfIntroduction,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.uid: uid,
      FirestoreConstants.nickname: nickname,
      FirestoreConstants.gender: gender,
      FirestoreConstants.myMbti: myMbti,
      FirestoreConstants.preferredMbti: preferredMbti,
      FirestoreConstants.selfIntroduction: selfIntroduction,
    };
  }

  factory MbtiUserInfo.fromDocument(DocumentSnapshot doc) {
    String uid = doc.get(FirestoreConstants.uid);
    String nickname = doc.get(FirestoreConstants.nickname);
    Gender gender = doc.get(FirestoreConstants.gender);
    Mbti myMbti = doc.get(FirestoreConstants.myMbti);
    List<Mbti> preferredMbti = doc.get(FirestoreConstants.preferredMbti);
    String? selfIntroduction = doc.get(FirestoreConstants.selfIntroduction);
    return MbtiUserInfo(
      uid: uid,
      nickname: nickname,
      myMbti: myMbti,
      gender: gender,
      preferredMbti: preferredMbti,
      selfIntroduction: selfIntroduction,
    );
  }
}
