class Article {
  final String title;

  final String time;
  final String url;

  Article({required this.title, required this.time, required this.url});

  factory Article.formMap(dynamic map) {
    return Article(
      title: map['title'] ?? '未知',
      url: map['link'] ?? '',
      time: map['niceDate'] ?? '',
    );
  }
  @override
  String toString() {
    return 'Article{title: $title, time: $time, url: $url}';
  }
}
