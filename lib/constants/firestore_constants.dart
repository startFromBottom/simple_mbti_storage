class FirestoreConstants {
  static const chattingRoomsBucket = "chatting_rooms";
  static const mbtiUserInfoBucket = "mbti_user_info";

  static const messagesCollection = "messages";

  // chatting_rooms fields.
  static const chattingRoomId = "room_id";
  static const idFrom = "idFrom";
  static const idTo = "idTo";
  static const createdAt = "createdAt";

  // messages fields.
  static const timestamp = "timestamp";
  static const content = "content";
  static const type = "type";

  // Mbti User Info fields.
  static const uid = "uid";
  static const nickname = "nickname";
  static const gender = "gender";
  static const myMbti = "mbti";
  static const preferredMbti = "preferred_mbti";
  static const selfIntroduction = "self_introduction";
}
