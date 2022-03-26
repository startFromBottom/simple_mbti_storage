import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:provider/provider.dart';
import 'package:simple_mbti_store/model/mbti_user_model.dart';
import 'package:simple_mbti_store/service/auth_service.dart';
import 'package:simple_mbti_store/service/mbti_user_info_service.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({Key? key}) : super(key: key);

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  @override
  Widget build(BuildContext context) {
    // User? user

    return Consumer<MbtiUserInfoService>(
      builder: (context, mbtiUserInfoService, child) {
        final authService = context.read<AuthService>();
        User user = authService.currentUser()!;
        String myId = user.uid;

        return Column(
          children: [
            Expanded(
              child: StreamBuilder<DocumentSnapshot>(
                stream: mbtiUserInfoService.readMbtiUserInfoStream(myId),
                builder: (context, documentSnapshot) {
                  final doc = documentSnapshot.data;
                  MbtiUserInfo? myMbtiUserInfo;
                  if (doc != null) {
                    myMbtiUserInfo = MbtiUserInfo.fromDocument(doc);
                  } else {
                    // TODO (hyuem) : define new Exception
                    throw Exception("cannot find MbtiUserInfo from my uid");
                  }
                  return StreamBuilder<QuerySnapshot>(
                    stream: mbtiUserInfoService
                        .readRecommendedMbtiUsersStream(myMbtiUserInfo),
                    builder: (context, querySnapshot) {
                      final documentSnapshots = querySnapshot.data?.docs ?? [];
                      if (documentSnapshots.isEmpty) {
                        return Center(
                          child: Text("no recommended users"),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: documentSnapshots.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = documentSnapshots[index];
                          MbtiUserInfo yourMbtiUserInfo =
                              MbtiUserInfo.fromDocument(doc);

                          return GestureDetector(
                            child: ListTile(
                              leading: FlutterLogo(size: 72.0),
                              title: Text(
                                yourMbtiUserInfo.nickname,
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle:
                                  Text(yourMbtiUserInfo.selfIntroduction ?? ""),
                            ),
                            onTap: () {
                              // goToPage(context, ChattingPage());
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
