// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mbti_store/constants/route_constants.dart';
import 'package:simple_mbti_store/onboarding.dart';
import 'package:simple_mbti_store/service/chatting_room_service.dart';
import 'package:simple_mbti_store/ui/main_page/main_page.dart';
import 'package:simple_mbti_store/utils/widget_utils.dart';
// MBTI class를 하나 만들어두면 편하겠네요.
// MBTI, 속성
// (예시)
// "ENTP", "상상력이 풍부하여 철두철미한 계획을 세우는 전략가형"

// class를 기준으로 List를 하나 만들면 좋을 거 같아요.

// <<<<<<< HEAD
// >>>>>>> 9517b629bae855345694bbc4d244e389135618bf

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChattingRoomService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        RouteConstants.MainPage: (context) => MainPage(),
      },
      debugShowCheckedModeBanner: false,
      home: AppListPage(),
    );
  }
}

class AppListPage extends StatelessWidget {
  const AppListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MBTI"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  goToPage(context, Onboarding());
                },
                child: Text("onboading"),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO implemented.
                },
                child: Text("login"),
              ),
              ElevatedButton(
                  onPressed: () {
                    goToPage(context, MainPage());
                  },
                  child: Text("main")),
              ElevatedButton(onPressed: () {}, child: Text("my page")),
            ],
          ),
        ),
      ),
    );
  }
}
