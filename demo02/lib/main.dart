import 'package:demo02/main/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import "counter/counter_page.dart";
// import "guess/guess_page.dart";
// import 'package:demo02/muyu/muyu_page.dart';
// import 'package:demo02/paper/paper_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确保平台通道正确初始化
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '测试apk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // 主题色
        // primarySwatch: Colors.blue, // 主题色
        // 设置appBar主题配置
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      // home: const GuessPage(title: '猜数字'),
      // home: const MuyuPage(title: '点赞动效'),
      home: const AppNavigation(),
    );
  }
}
