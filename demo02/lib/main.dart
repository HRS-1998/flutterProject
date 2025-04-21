import 'package:demo02/main/app_navigation.dart';
import 'package:flutter/material.dart';
// import "counter/counter_page.dart";
// import "guess/guess_page.dart";
// import 'package:demo02/muyu/muyu_page.dart';
// import 'package:demo02/paper/paper_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // 主题色
        // primarySwatch: Colors.blue, // 主题色
      ),
      // home: const GuessPage(title: '猜数字'),
      // home: const MuyuPage(title: '点赞动效'),
      home: AppNavigation(),
    );
  }
}
