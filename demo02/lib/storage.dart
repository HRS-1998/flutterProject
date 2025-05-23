import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String kGuessSpKey = 'guess_config';

class SpStorage {
  SpStorage._(); // 私有构造函数
  static SpStorage? _storage; // 保存单例

  static SpStorage get instance {
    _storage = _storage ?? SpStorage._();
    return _storage!;
  }

  SharedPreferences? _sp;
  Future<void> initSpWhenNull() async {
    if (_sp != null) return;
    _sp = _sp ?? await SharedPreferences.getInstance();
  }

  Future<bool> saveGuessConfig({
    required bool guessing,
    required int value,
  }) async {
    await initSpWhenNull();
    String content = json.encode({'guessing': guessing, 'value': value});
    return _sp!.setString(kGuessSpKey, content);
  }

  Future<Map<String, dynamic>> readGuessConfig() async {
    await initSpWhenNull();
    String content = _sp!.getString(kGuessSpKey) ?? "{}";
    return json.decode(content);
  }
}
