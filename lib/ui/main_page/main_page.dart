import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:simple_mbti_store/ui/main_page/chatting_page.dart';
import 'package:simple_mbti_store/ui/main_page/chatting_room_list_page.dart';
import 'package:simple_mbti_store/ui/main_page/map.dart';
import 'package:simple_mbti_store/ui/main_page/recommendation.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ]),
        body: IndexedStack(
          index: currentIndex,
          children: [
            RecommendationPage(),
            ChattingRoomListPage(),
            MapPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "추천 리스트"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "채팅"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "지도"),
          ],
        ),
      ),
      onWillPop: () async {
        // back button 비활성화
        return false;
      },
    );
  }
}
