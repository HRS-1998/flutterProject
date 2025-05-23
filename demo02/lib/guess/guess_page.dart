import 'package:demo02/guess/guess_app_bar.dart';
import 'package:demo02/guess/result_notice.dart';
import 'package:demo02/storage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});

  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _initConfig();
  }

  void _initConfig() async {
    var config = await SpStorage.instance.readGuessConfig();
    _guessing = config['guessing'] ?? false;
    _value = config['value'] ?? 0;
    setState(() {});
  }

  int _value = 0;
  bool _guessing = false;
  bool? _isBig;

  final _random = Random();

  void _generateRandomValue() {
    setState(() {
      _guessing = true;
      _value = _random.nextInt(100);
      SpStorage.instance.saveGuessConfig(guessing: _guessing, value: _value);
      // _guessing = false;
    });
  }

  final TextEditingController _guesscontroller = TextEditingController();

  void _onCheck() {
    print('check:目标数值为:$_value,输入值为:${_guesscontroller.text}');
    int? guessValue = int.tryParse(_guesscontroller.text);
    // 游戏未开始或者输入非整数，无视
    if (!_guessing || guessValue == null) {
      return;
    }
    _controller.forward(from: 0);
    // 猜对了
    if (guessValue == _value) {
      setState(() {
        _isBig = null;
        _guessing = false;
        SpStorage.instance.saveGuessConfig(guessing: false, value: _value);
      });
      return;
    }

    // 猜错了
    setState(() {
      _isBig = guessValue > _value;
      // _guessing = false;
    });
  }

  @override
  void dispose() {
    _guesscontroller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppBar(controller: _guesscontroller, onCheck: _onCheck),
      body: Stack(
        children: [
          if (_isBig != null)
            Column(
              children: [
                if (_isBig!)
                  ResultNotice(result: "大了", color: Colors.redAccent),
                Spacer(),
                if (!_isBig!)
                  ResultNotice(result: "小了", color: Colors.blueAccent),
              ],
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_guessing) const Text('点击生成随机数值'),
                Text(
                  _guessing ? '**' : '$_value',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.blue,
        tooltip: 'GenerateRandomValue',
        shape: CircleBorder(),
        child: const Icon(
          Icons.generating_tokens_outlined,
          color: Colors.white,
        ),
        // 圆形
      ),
    );
  }
}
