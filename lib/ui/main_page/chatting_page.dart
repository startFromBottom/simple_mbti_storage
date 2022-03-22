import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mbti_store/constants/color_constants.dart';
import 'package:simple_mbti_store/model/chatting_rooms.dart';
import 'package:simple_mbti_store/service/chatting_service.dart';

/*
 1:1 채팅방 내부.
*/

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key}) : super(key: key);

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // User.
    // for test
    // TODO(hyuem) : user의 Service 객체로부터 받아오도록 수정.
    String myId = "1";
    String yourId = "2";
    String chattingRoomId = "1-2";

    return Scaffold(
      appBar: AppBar(
        title: Text("chatting room"),
        actions: [
          IconButton(
            onPressed: () {
              // 채팅방 삭제
              ChattingService chattingService = context.read<ChattingService>();
              chattingService.deleteChattingRoom(chattingRoomId);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ChattingService>(
            builder: (context, chattingService, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chatController,
                        decoration: InputDecoration(
                          hintText: "채팅 입력",
                        ),
                      ),
                    ),

                    // 추가 버튼
                    ElevatedButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        if (chatController.text.isNotEmpty) {
                          chattingService.writeMessageInChattingRoom(
                            chattingRoomId,
                            Message(
                              idFrom: myId,
                              idTo: yourId,
                              content: chatController.text,
                              timestamp: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              // TODO(hyuem) : 이미지 확장 필요.
                              type: MessageType.text,
                            ),
                          );
                          chatController.text = "";
                        }
                      },
                    )
                  ],
                ),
              ),
              Divider(height: 1),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: chattingService.readMessagesStream(chattingRoomId),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    final documents = snapshot.data?.docs ?? [];
                    if (documents.isEmpty) {
                      return Center(
                        child: Text("비어 있는 텍스트"),
                      );
                    }
                    return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot? doc = documents[index];
                          Message message = Message.fromDocument(doc);
                          // TODO(hyuem) : text 뿐만 아니라 이미지도 커버 가능하도록!
                          return Container(
                            child: Text(
                              message.content,
                              style:
                                  TextStyle(color: ColorConstants.primaryColor),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            width: 200,
                            decoration: BoxDecoration(
                                color: ColorConstants.greyColor,
                                borderRadius: BorderRadius.circular(8)),
                            margin: EdgeInsets.only(
                                // bottom: isLastMessageRight(index) ? 20 : 10,
                                bottom: 20,
                                right: 10),
                          );
                        });
                  },
                ),
              )

              //
              // Expanded(child: StreamBuilder<QuerySnapshot>(
              //   stream: c,
              // ),)
            ],
          );
        }),
      ),
    );
  }
}
