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
              Text("당신의 MBTI를 알려주세요"),
              TextField(),
              TextButton(
                onPressed: () {},
                child: Text("MBTI 결과를 모르시나요?"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => OnboardingRecommendMBTI()),
                  );
                },
                child: Text("다음"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingRecommendMBTI extends StatelessWidget {
  const OnboardingRecommendMBTI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("ㅇㅇㅇ와 가장 잘맞는 궁합이예요"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OnboardingNickname()),
                  );
                },
                child: Text("다음"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingNickname extends StatelessWidget {
  const OnboardingNickname({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("앞으로 사용할 별명을 입력해주세요."),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OnboardingIntoduction()),
                  );
                },
                child: Text("다음"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingIntoduction extends StatelessWidget {
  const OnboardingIntoduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("간단하게 소개해주세요."),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OnboardingWelcome()),
                  );
                },
                child: Text("다음"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingWelcome extends StatelessWidget {
  const OnboardingWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("Welcome"),
              ElevatedButton(
                onPressed: () {
                  // 메인으로 넘어갑니다.
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => OnboardingWelcome()),
                  // );
                },
                child: Text("다음"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
