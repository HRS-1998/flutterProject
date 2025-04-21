import 'package:demo02/paper/back_up_buttons.dart';
import 'package:flutter/material.dart';

class PaperAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onClear;
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;
  const PaperAppbar({
    super.key,
    required this.title,
    required this.onClear,
    this.onBack,
    this.onRevocation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        width: 90,
        child: BackUpButtons(onBack: onBack, onRevocation: onRevocation),
      ),
      centerTitle: true,
      title: Text(title),
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          splashRadius: 20,
          onPressed: onClear,
          icon: Icon(Icons.delete, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // 实现 preferredSize,
}
