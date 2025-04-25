import 'package:demo02/netarticle/model/article_model.dart';
import 'package:dio/dio.dart';

class ArticleApi {
  static const String kBaseUrl = 'https://www.wanandroid.com';
  final Dio _client =
      Dio(BaseOptions(baseUrl: kBaseUrl))
        ..options.connectTimeout = const Duration(seconds: 60)
        ..options.receiveTimeout = const Duration(
          seconds: 60,
        ); // 设置接收数据超时时间为10秒 设置连接超时时间为10秒

  Future<List<Article>> getArticleList(int page) async {
    try {
      String path = '/article/list/$page/json';
      var response = await _client.get(path);

      if (response.statusCode == 200 && response.data != null) {
        var data = response.data['data']['datas'] as List?;
        if (data != null) {
          return data.map((item) => Article.formMap(item)).toList();
        }
      }
      return []; // 如果数据为空，返回空列表
    } on DioException catch (e) {
      // 捕获Dio相关的异常
      if (e.type == DioExceptionType.connectionError) {
        print(e);
        print('网络连接失败，请检查您的网络设置或服务器地址是否正确');
      } else {
        print('请求失败: $e');
      }
      return []; // 返回空列表以避免调用方崩溃
    } catch (e) {
      // 捕获其他未知异常
      print('未知错误: $e');
      return [];
    }
  }
}
