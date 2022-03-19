// 온보딩 화면 구현합니다.
// 로그인 -> 온보딩 -> 메인 으로 진행됩니다.
// 온보딩은 1회 이상 완료하면 더 이상 보여지지 않습니다.

import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Text("onboarding"),
            ],
          ),
        ),
      ),
    );
  }
}
