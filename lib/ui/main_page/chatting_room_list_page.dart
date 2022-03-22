import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mbti_store/model/chatting_rooms.dart';
import 'package:simple_mbti_store/service/chatting_service.dart';
import 'package:simple_mbti_store/ui/main_page/chatting_page.dart';
import 'package:simple_mbti_store/utils/widget_utils.dart';

class ChattingRoomListPage extends StatefulWidget {
  const ChattingRoomListPage({Key? key}) : super(key: key);

  @override
  State<ChattingRoomListPage> createState() => _ChattingRoomListPageState();
}

class _ChattingRoomListPageState extends State<ChattingRoomListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChattingService>(
        builder: (context, chattingService, child) {
      // User
      // for test
      // TODO(hyuem) : user의 Service 객체로부터 받아오도록 수정.
      String myId = "1";
      String yourId = "2";
      String chattingRoomId = "1-2";

      return Column(
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: chattingService.readChattingRooms(myId),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                final documents = snapshot.data?.docs ?? [];
                if (documents.isEmpty) {
                  return Center(
                    child: Text("no chatting rooms"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot? doc = documents[index];
                    ChattingRoom chattingRoom = ChattingRoom.fromDocument(doc);

                    String createdAt = chattingRoom.createdAt;

                    // user의 이름, 사진 정보 가져오기
                    return GestureDetector(
                      child: ListTile(
                        // ChattingRoom 의 idFrom 또는 idTo에 해당하는
                        leading: FlutterLogo(size: 72.0),
                        // 유저의 이름
                        title: Text(
                          "Lucy",
                          style: TextStyle(color: Colors.black),
                        ),
                        // 생성 시간 -> 마지막 업데이트된 시간으로 변경.
                        subtitle: Text(createdAt),
                      ),
                      onTap: () {
                        goToPage(context, ChattingPage());
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      );
    });
  }
}
