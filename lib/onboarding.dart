// 온보딩 화면 구현합니다.
// 로그인 -> 온보딩 -> 메인 으로 진행됩니다.
// 온보딩은 1회 이상 완료하면 더 이상 보여지지 않습니다.

import 'package:flutter/material.dart';

String myMBTI = "test";

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double mbtiBoxSize = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 48,
            ),
            Text(
              "당신의 MBTI를 알려주세요.",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("당신의 MBTI를 모르시나요?"),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: SizedBox(
                height: mbtiBoxSize * 4 - 32,
                width: mbtiBoxSize * 4 - 32,
                child: GridView(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 1,
                    ),
                    children: [
                      mbtiBox("INTJ", mbtiBoxSize, Colors.purple, Colors.white),
                      mbtiBox("INTP", mbtiBoxSize, Colors.purple, Colors.white),
                      mbtiBox("ENTJ", mbtiBoxSize, Colors.purple, Colors.white),
                      mbtiBox("ENTP", mbtiBoxSize, Colors.purple, Colors.white),
                      mbtiBox("INFJ", mbtiBoxSize, Colors.green, Colors.white),
                      mbtiBox("INFP", mbtiBoxSize, Colors.green, Colors.white),
                      mbtiBox("ENFJ", mbtiBoxSize, Colors.green, Colors.white),
                      mbtiBox("ENFP", mbtiBoxSize, Colors.green, Colors.white),
                      mbtiBox(
                          "ISTJ", mbtiBoxSize, Colors.lightBlue, Colors.white),
                      mbtiBox(
                          "ISFJ", mbtiBoxSize, Colors.lightBlue, Colors.white),
                      mbtiBox(
                          "ESTJ", mbtiBoxSize, Colors.lightBlue, Colors.white),
                      mbtiBox(
                          "ESFJ", mbtiBoxSize, Colors.lightBlue, Colors.white),
                      mbtiBox("ISTP", mbtiBoxSize, Colors.amber, Colors.white),
                      mbtiBox("ISFP", mbtiBoxSize, Colors.amber, Colors.white),
                      mbtiBox("ESTP", mbtiBoxSize, Colors.amber, Colors.white),
                      mbtiBox("ESFP", mbtiBoxSize, Colors.amber, Colors.white),
                    ]),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "당신은 $myMBTI이군요!",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("(예시)상상력이 풍부하여 철두철미한 계획을 세우는 전략가형",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OnboardingRecommendMBTI()),
                            );
                          },
                          child: Text("다음"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mbtiBox(String mbti, double size, Color colorBox, colorText) {
    return GestureDetector(
      onTap: () {
        setState(() {
          myMBTI = mbti;
          // print(myMBTI);
        });
      },
      child: Container(
        width: size,
        height: size,
        color: colorBox,
        child: Center(
          child: Text(
            mbti,
            style: TextStyle(
              color: colorText,
              fontSize: 24,
              // fontWeight: FontWeight.bold,
            ),
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
