import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo02/muyu/muyu_count_panel.dart';
import 'package:demo02/muyu/muyu_image.dart';
import 'package:demo02/muyu/muyu_animate_text.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:demo02/muyu/models/image_option.dart';
import 'package:demo02/muyu/models/audio_option.dart';
import 'package:demo02/muyu/options/select_image.dart';
import 'package:demo02/muyu/options/select_audio.dart';
import 'dart:math';

class MuyuPage extends StatefulWidget {
  final String title;
  const MuyuPage({super.key, required this.title});
  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {
  int _count = 0;
  int _curValue = 0;
  final _random = Random();
  final List<ImageOption> imageOptions = [
    ImageOption("基础版", "assets/images/aa.png", 1, 3),
    ImageOption("尊享版", "assets/images/bb.png", 3, 6),
  ];
  int _activeImageIndex = 0;
  int _activeAudioIndex = 0;
  final List<AudioOption> _audioOptions = [
    AudioOption('muyu_1', 'assets/audio/muyu_1.mp3'),
    AudioOption('muyu_2', 'assets/audio/muyu_2.mp3'),
    AudioOption('muyu_3', 'assets/audio/muyu_3.mp3'),
  ];
  AudioPool? pool;
  // MuyuAssetsImage(image:activeImage,onTap:_onkonck),
  void _onkonck() {
    pool?.start();
    setState(() {
      _curValue = knockValue; // 随机数
      _count += _curValue;
    });
  }

  void _onTapSwitchAudio() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return AudioPanel(
          audioOptions: _audioOptions,
          activeIndex: _activeAudioIndex,
          onSelect: _onAudioSelect,
        );
      },
    );
  }

  void _onAudioSelect(int index) {
    Navigator.of(context).pop();
    if (index == _activeAudioIndex) return;
    setState(() {
      _activeAudioIndex = index;
      _updateAudioPool();
    });
  }

  void _onTapSwitchImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ImageOptionPanel(
          imageOptions: imageOptions,
          activeIndex: _activeImageIndex,
          onSelect: _onImageSelect,
        );
      },
    );
  }

  void _onImageSelect(int index) {
    Navigator.of(context).pop();
    if (index == _activeImageIndex) return;
    setState(() {
      _activeImageIndex = index;
    });
  }

  // 激活图像
  String get activeImage => imageOptions[_activeImageIndex].imageUrl;
  // 点击时需要增加的值
  int get knockValue {
    int min = imageOptions[_activeImageIndex].min;
    int max = imageOptions[_activeImageIndex].max;
    return min + _random.nextInt(max + 1 - min);
  }

  void _initAudioPool() async {
    pool = await FlameAudio.createPool(
      _audioOptions[_activeAudioIndex].audioUrl,
      maxPlayers: 4,
    );
  }

  void _updateAudioPool() async {
    pool = await FlameAudio.createPool(
      _audioOptions[_activeAudioIndex].audioUrl,
      maxPlayers: 4,
    );
  }

  @override
  void initState() {
    super.initState();
    _initAudioPool();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: _toHistory, icon: const Icon(Icons.history)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CountPanel(
              count: _count,
              onTapSwitchAudio: _onTapSwitchAudio,
              onTapSwitchImage: _onTapSwitchImage,
            ),
          ),
          Expanded(
            // child: MuyuImage(
            //   imageUrl: 'assets/images/muyu.png',
            //   onTap: _onkonck,
            // ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                MuyuImage(imageUrl: activeImage, onTap: _onkonck),
                if (_curValue != 0) AnimateText(text: '数值+$_curValue'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toHistory() {}

  // Widget _buildTopContent() {
  //   // 按钮样式
  //   final ButtonStyle style = ElevatedButton.styleFrom(
  //     minimumSize: const Size(36, 36), // 最小尺寸
  //     padding: EdgeInsets.zero, // 边距
  //     backgroundColor: Colors.green, // 背景色
  //     elevation: 0, // 阴影深度
  //   );

  //   return Stack(
  //     children: [
  //       Center(
  //         child: Text(
  //           '功德数: 0',
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //       ),

  //       Positioned(
  //         right: 10,
  //         top: 10,
  //         child: Wrap(
  //           spacing: 8,
  //           direction: Axis.vertical,
  //           children: [
  //             ElevatedButton(
  //               style: style,
  //               onPressed: () {},
  //               child: Icon(Icons.music_note_outlined),
  //             ),
  //             ElevatedButton(
  //               style: style,
  //               onPressed: () {},
  //               child: Icon(Icons.image),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildImage() {
  //   return Center(
  //     child: Image.asset(
  //       'assets/images/muyu.png',
  //       height: 200, //图片高度
  //     ),
  //   );
  // }
}
