import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mbti_store/constants/color_constants.dart';
import 'package:simple_mbti_store/constants/route_constants.dart';
import 'package:simple_mbti_store/model/chatting_room_model.dart';
import 'package:simple_mbti_store/model/message_model.dart';
import 'package:simple_mbti_store/service/chatting_room_service.dart';
import 'package:simple_mbti_store/ui/main_page/chatting_room_list_page.dart';
import 'package:simple_mbti_store/ui/main_page/main_page.dart';
import 'package:simple_mbti_store/utils/widget_utils.dart';

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
    // TODO(hyuem) : get User data from firebase.
    String myId = "1";
    String yourId = "2";
    String chattingRoomId = "1-2";

    return Scaffold(
      appBar: AppBar(
        title: Text("chatting room"),
        actions: [
          IconButton(
            onPressed: () {
              // TODO(hyuem) : add popup page.
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  // TODO(hyuem) : extract widget.
                  return AlertDialog(
                    title: Text("채팅방 나가기"),
                    content: Text("채팅방을 나가시겠습니까?"),
                    actions: [
                      TextButton(
                        child: Text('아니오'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('네'),
                        onPressed: () {
                          ChattingRoomService chattingService =
                              context.read<ChattingRoomService>();
                          // for debugging.
                          chattingService.deleteChattingRoom(chattingRoomId);
                          Navigator.pushNamed(context, RouteConstants.MainPage);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ChattingRoomService>(
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

                    // add button
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
                              // TODO(hyuem) : support image type also.
                              type: MessageType.text,
                            ),
                          );
                          chatController.text = "";
                        }
                      },
                    ),
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
                        // TODO(hyuem) : support image type also.
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
                            color: setMessageBackGroundColorByMyUserId(message,
                                myId, Colors.blueGrey, Colors.lightGreen),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.only(
                            bottom: 20,
                            right: 10,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // TODO(hyuem) : not only color but also other properties should be changed by myId.
  Color setMessageBackGroundColorByMyUserId(Message message, String myId,
      Color myMessageColor, Color yourMessageColor) {
    // My message
    if (message.idFrom == myId) {
      return myMessageColor;
    }
    // Your message
    return yourMessageColor;
  }
}
