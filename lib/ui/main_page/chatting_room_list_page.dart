import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mbti_store/model/chatting_room_model.dart';
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
      // for test
      // TODO(hyuem) : get User data from firebase.
      String myId = "1";
      String yourId = "2";
      String chattingRoomId = "1-2";

      return Column(
        children: [
          Expanded(
            child: StreamBuilder<List<QuerySnapshot>>(
              stream: chattingService.readChattingRoomsStream(myId),
              builder: (context, snapshot) {
                // TODO(hyuem) : need to refactor.
                List<DocumentSnapshot> documentSnapshots = [];
                List<QuerySnapshot<Object?>>? querySnapshots =
                    snapshot.data?.toList();

                for (var query in querySnapshots!) {
                  documentSnapshots.addAll(query.docs);
                }

                if (snapshot.data == null || documentSnapshots.isEmpty) {
                  return Center(
                    child: Text("no chatting rooms"),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: documentSnapshots.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot? doc = documentSnapshots[index];
                    ChattingRoom chattingRoom = ChattingRoom.fromDocument(doc);

                    String createdAt = chattingRoom.createdAt;

                    return GestureDetector(
                      child: ListTile(
                        // use idFrom or idTo field.
                        leading: FlutterLogo(size: 72.0),
                        //  user name
                        title: Text(
                          "Lucy",
                          style: TextStyle(color: Colors.black),
                        ),
                        // TODO(hyuem) as_is : createdAt -> to_be : lastUpdatedAt.
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
