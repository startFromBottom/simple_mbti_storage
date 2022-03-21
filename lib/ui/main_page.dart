import 'package:flutter/material.dart';
import 'package:simple_mbti_store/ui/main_page/chatting.dart';
import 'package:simple_mbti_store/ui/main_page/map.dart';
import 'package:simple_mbti_store/ui/main_page/recommendation.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  // final Map<S pageNameList = ["list", "chatting", "map"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ChattingPage(),
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
    );
  }
}
