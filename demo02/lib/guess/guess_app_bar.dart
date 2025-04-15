import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCheck;
  final TextEditingController controller;
  const GuessAppBar({
    super.key,
    required this.controller,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu, color: Colors.black),
      actions: [
        IconButton(
          splashRadius: 20,
          onPressed: onCheck,
          icon: Icon(Icons.run_circle_outlined, color: Colors.blue),
        ),
      ],
      title: TextField(
        controller: controller,
        keyboardType: TextInputType.number, // 设置键盘类型为数字键盘
        decoration: InputDecoration(
          // 装饰
          filled: true, // 填充
          fillColor: Color(0xffF3F6F9), // 填充颜色
          // constraints: BoxConstraints(maxHeight: 60), // 约束 限制高度
          border: UnderlineInputBorder(
            // 边框
            borderRadius: BorderRadius.all(Radius.circular(6)), // 圆角
            borderSide: BorderSide.none, // 无边框
          ),
          hintText: "输入 0~99 数字", // 提示文字
          hintStyle: TextStyle(fontSize: 14), // 提示文字样式
          // prefixIcon: Icon(Icons.search, color: Colors.black),
          // suffixIcon: IconButton(
          //   onPressed: () {
          //     _generateRandomValue();
          //   },
          // ),
        ),
      ),
      //  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      systemOverlayStyle: SystemUiOverlayStyle(
        // 状态栏样式
        statusBarColor: Colors.transparent, // 状态栏颜色
        statusBarIconBrightness: Brightness.dark, // 状态栏图标颜色
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // 实现 preferredSize
}
