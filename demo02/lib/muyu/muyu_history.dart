import 'package:flutter/material.dart';
import 'package:demo02/muyu/models/history_option.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  final String title;
  final List<HistoryItem> historyItems;

  const HistoryPage({
    super.key,
    required this.title,
    required this.historyItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) => _historyItem(historyItems[index]),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Colors.black, fontSize: 16.0)),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  Widget _historyItem(HistoryItem item) {
    DateFormat dateFormat = DateFormat('yyyy年MM月dd日 HH:mm:ss');
    String date = dateFormat.format(
      DateTime.fromMillisecondsSinceEpoch(item.date),
    );
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage(item.imageUrl),
      ),
      title: Text(
        '点赞 +${item.value}',
        // 过长隐藏
        style: TextStyle(
          fontSize: 16,
          overflow: date.length > 15 ? TextOverflow.ellipsis : null,
        ),
      ),
      subtitle: Text(item.audioName),
      trailing: Text(date, style: TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }
}
