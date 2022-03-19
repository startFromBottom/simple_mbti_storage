import 'package:flutter/material.dart';
import 'package:simple_mbti_store/onboarding.dart';

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
