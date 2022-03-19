import 'package:flutter/material.dart';
import 'package:simple_mbti_store/onboarding.dart';

// MBTI class를 하나 만들어두면 편하겠네요.
// MBTI, 속성
// (예시)
// "ENTP", "상상력이 풍부하여 철두철미한 계획을 세우는 전략가형"

// class를 기준으로 List를 하나 만들면 좋을 거 같아요.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Onboarding()),
                    );
                  },
                  child: Text("onboading")),
              ElevatedButton(onPressed: () {}, child: Text("login")),
              ElevatedButton(onPressed: () {}, child: Text("main")),
              ElevatedButton(onPressed: () {}, child: Text("my page")),
            ],
          ),
        ),
      ),
    );
  }
}
