import 'package:demo02/netarticle/model/article_model.dart';
import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  @override
  const ArticleItem({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        article.title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Text(
        article.url,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      trailing: Text(
        article.time,
        style: TextStyle(fontSize: 10, color: Colors.grey),
      ),
      onTap: onTap,
    );
  }
}
