import 'dart:io';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

Map<int, String> testMap = {1: "one", 2: "two", 3: "three"};
final _logger = Logger('z01');

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

Future<void> asyncFunTest() async {
  String scriptPath = Platform.script.toFilePath();
  String dirPath = path.dirname(scriptPath);
  String pubspecPath = path.join(path.dirname(dirPath), 'pubspec.yaml');

  _logger.info('尝试读取文件: $pubspecPath');
  File file = File(
    r'E:\vspo-feat-demo\flutterProject\demo01\test\widget_test.dart',
  );
  _logger.info(await file.exists());
  _logger.info("开始读取文件");
  String value = await file.readAsString();
  _logger.info("读取文件成功：");
  _logger.info(value.substring(0, 100));
}

void main() async {
  setupLogging();
  int age = 12;
  double weight = 60.5;
  double sum = age + weight;
  _logger.warning("age: $age,weight:$weight,sum:$sum");
  testMap.forEach((key, value) {
    _logger.info("key:$key,value:$value");
  });
  await asyncFunTest();
}
