import 'package:demo02/netarticle/views/article_content.dart';
import 'package:flutter/material.dart';

class NetArticlePage extends StatelessWidget {
  final String title;
  @override
  const NetArticlePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.white),
      body: const ArcticleContent(),
    );
  }
}
