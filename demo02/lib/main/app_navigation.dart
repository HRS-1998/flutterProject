import 'package:demo02/guess/guess_page.dart';
import 'package:demo02/main/app_bottom_bar.dart';
import 'package:demo02/main/main_model.dart';
import 'package:demo02/muyu/muyu_page.dart';
import 'package:demo02/paper/paper_page.dart';
import 'package:demo02/netarticle/views/netarticle_page.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _currentIndex = 0;

  final List<MenuData> menus = const [
    MenuData(label: '猜数字', icon: Icons.question_mark),
    MenuData(label: '点赞', icon: Icons.my_library_music_outlined),
    MenuData(label: '白板绘制', icon: Icons.palette_outlined),
    MenuData(label: '网络文章', icon: Icons.article_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Expanded(child: _buildContent(_currentIndex)),
    //     AppBottomBar(
    //       currentIndex: _currentIndex,
    //       menus: menus,
    //       onItemTap: _onItemTap,
    //     ),
    //   ],
    // );
    //解决guess界面遮盖问题
    return Scaffold(
      body: _buildContent(_currentIndex),
      bottomNavigationBar: AppBottomBar(
        currentIndex: _currentIndex,
        menus: menus,
        onItemTap: _onItemTap,
      ),
    );
  }

  final PageController _pageController = PageController();

  Widget _buildContent(int index) {
    // switch (index) {
    //   case 0:
    //     return const GuessPage(title: '猜数字');
    //   case 1:
    //     return const MuyuPage(title: "点赞");
    //   case 2:
    //     return const PaperPage(title: "画板绘制");
    //   default:
    //     return SizedBox.shrink();
    // }
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        const GuessPage(title: '猜数字'),
        const MuyuPage(title: "点赞"),
        const PaperPage(title: "画板绘制"),
        const NetArticlePage(title: "网络文章"),
      ],
    );
  }

  void _onItemTap(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }
}
