import 'package:demo02/netarticle/api/article_api.dart';
import 'package:demo02/netarticle/model/article_model.dart';
import 'package:demo02/netarticle/views/article_detail.dart';
import 'package:demo02/netarticle/views/article_item.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class ArcticleContent extends StatefulWidget {
  const ArcticleContent({super.key});

  @override
  State<ArcticleContent> createState() => _ArcticleContentState();
}

class _ArcticleContentState extends State<ArcticleContent> {
  List<Article> _articles = [];
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ArticleApi api = ArticleApi();
  void _loadData() async {
    _loading = true;
    setState(() {});
    _articles = await api.getArticleList(0);
    _loading = false;
    print(_articles);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: Wrap(
          spacing: 10,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('加载中...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return EasyRefresh(
      header: const ClassicHeader(
        dragText: '下拉刷新',
        armedText: '释放刷新',
        processingText: '正在刷新...',
        processedText: '刷新成功',
      ),
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: ListView.builder(
        //
        itemExtent: 80,
        itemCount: _articles.length,
        itemBuilder: _buildItem,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ArticleItem(
      article: _articles[index],
      onTap: () => _jumpToDetail(_articles[index]),
    );
  }

  void _onRefresh() async {
    _articles = await api.getArticleList(0);
    setState(() {});
  }

  void _onLoad() async {
    int nextPage = _articles.length ~/ 20;
    List<Article> newArticle = await api.getArticleList(nextPage);
    _articles = _articles + newArticle;
    setState(() {});
  }

  void _jumpToDetail(Article article) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => ArticleDetail(article: article)));
  }
}
