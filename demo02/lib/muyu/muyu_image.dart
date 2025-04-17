import 'package:flutter/material.dart';

class MuyuImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const MuyuImage({super.key, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        // 使用GestureDetector来监听手势回调
        onTap: onTap,
        child: Image.asset(imageUrl, fit: BoxFit.cover, height: 200),
      ),
    );

    // return Image.asset(
    //   imageUrl,
    //   fit: BoxFit.cover,
    //   // width: double.infinity,
    //   height: 200,
    // );
  }
}
