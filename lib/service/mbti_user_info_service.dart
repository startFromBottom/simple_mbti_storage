import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_mbti_store/model/mbti_user_model.dart';
import 'package:simple_mbti_store/repository/mbti_user_info_repository.dart';

// TODO(hyuem) : check logic with test codes
class MbtiUserInfoService extends ChangeNotifier {
  final _mbtiUserInfoRepository = MbtiUserInfoRepository();

  void createMbtiUserInfo(MbtiUserInfo mbtiUserInfo) async {
    _mbtiUserInfoRepository.createMbtiUserInfo(mbtiUserInfo);
    notifyListeners();
  }

  readMbtiUserInfoStream(String myId) {
    _mbtiUserInfoRepository.readMbtiUserInfoStream(myId);
    notifyListeners();
  }

  Stream<QuerySnapshot<Object?>>? readRecommendedMbtiUsersStream(
      MbtiUserInfo mbtiUserInfo) {
    return _mbtiUserInfoRepository.readRecommendedMbtiUsersStream(mbtiUserInfo);
  }
}
