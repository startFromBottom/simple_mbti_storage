import 'package:flutter/material.dart';
import 'package:simple_mbti_store/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
              ElevatedButton(onPressed: () {}, child: Text("Onboarding")),
              ElevatedButton(onPressed: () {}, child: Text("Login")),
              ElevatedButton(onPressed: () {}, child: Text("Main")),
              ElevatedButton(onPressed: () {}, child: Text("My Page")),
            ],
          ),
        ),
      ),
    );
  }
}
